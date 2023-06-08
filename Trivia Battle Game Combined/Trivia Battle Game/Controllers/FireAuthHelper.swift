//
//  FireAuthHelper.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-06-07.
//

import Foundation
import FirebaseAuth

class FireAuthHelper : ObservableObject{
    
    @Published var user : User?{
        didSet{
            objectWillChange.send()
        }
    }
    
    func listenToAuthState(){
        
        Auth.auth().addStateDidChangeListener{ [weak self] _, user in
            
            guard let self = self else{
                //no change in auth state
                return
            }
            self.user = user
        }
    }
    
    func signUp(email : String, password : String){
        
        Auth.auth().createUser(withEmail : email, password : password){ [self] authResult, error in
            
            guard let result = authResult else{
                print(#function, "Error while signing up the user : \(error)")
                return
            }
            
            print(#function, "AuthResult : \(result)")
            
            switch authResult{
            case .none :
                print(#function, "Unable to create the account")
            case .some(_) :
                print(#function, "Succesfully created user account")
                self.user = authResult?.user
                
                UserDefaults.standard.set(self.user?.email, forKey: "KEY_EMAIL")
            }
            
        }
        
    }
    
    func signIn(email : String, password : String){
        
        Auth.auth().signIn(withEmail : email, password : password){ [self] authResult, error in
            
            guard let result = authResult else{
                print(#function, "Error while signing up the user : \(error)")
                return
            }
            
            print(#function, "AuthResult : \(result)")
            
            switch authResult{
            case .none :
                print(#function, "Unable to find the user the account")
            case .some(_) :
                print(#function, "Login Succesful")
                self.user = authResult?.user
                
                print(#function, "Welcome \(self.user?.displayName ?? "NA")")
                
                UserDefaults.standard.set(self.user?.email, forKey: "KEY_EMAIL")
            }
            
        }
        
    }
    
    func signOut(){
        do{
            
            try Auth.auth().signOut()
            
        }catch let signOutError as NSError{
            print(#function, "Unable to sign out user : \(signOutError)")
        }
    }
    
}
