//
//  LogInView.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-06-07.
//

import SwiftUI
import FirebaseAuth

struct LogInView: View {
    
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var confirmPassword : String = ""
    
    @State var linkSelection : Int? = nil
    
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    var body: some View {
        
        NavigationView{
            VStack {
                
                NavigationLink(destination: SignUpView().environmentObject(self.fireDBHelper), tag: 1, selection: self.$linkSelection){}
                NavigationLink(destination: MainView(), tag: 2, selection: self.$linkSelection){}
                
                Text("Trivia Batle Game")
                    .font(.custom("NerkoOne-Regular", size: 35))
                
                HStack {
                    Image(systemName: "mail")
                    TextField("Email", text: self.$email)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                    
                    if(email.count != 0) {
                        Image(systemName: email.count>0 ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                        //                        .foregroundColor(email.count>0 ? .green : .red)
                    }
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
                .padding()
                
                HStack {
                    Image(systemName: "lock")
                    SecureField("Password", text: self.$password)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                    
                    if(password.count != 0) {
                        Image(systemName: password.count>0 ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                        //                        .foregroundColor(isValidPassword(password) ? .green : .red)
                    }
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
                .padding()
                
                
                Button(action: {
                    self.linkSelection = 1
                }) {
                    Text("Create an account?")
                        .foregroundColor(.black.opacity(0.7))
                }
                
                Button {
                    print("trying to logIn")
                    
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
                            print(#function, "Welcome \(self.email)")
                            UserDefaults.standard.set(self.email, forKey: "KEY_EMAIL")
                            self.linkSelection = 2
                        }
                        
                    }
                    
                } label: {
                    
                    Text("Sign In")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: UIScreen.screenWidth/3)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.black))
                }
                
                Spacer()
                
                Text("© by Winona Lee and Arnulfo Sánchez")
                    .font(.custom("NerkoOne-Regular", size: 15))
            }//VStack ends
        }//NavigationView ends
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        
    }//body ends
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
