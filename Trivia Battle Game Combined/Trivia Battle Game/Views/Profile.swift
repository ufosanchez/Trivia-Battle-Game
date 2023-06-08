//
//  Profile.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-05-30.
//

import SwiftUI
import FirebaseAuth

struct Profile: View {
    
    @State var linkSelection : Int? = nil
    var singleton = Singleton.shared
    
    var body: some View {
        
        VStack{
            NavigationLink(destination: LogInView(), tag: 1, selection: self.$linkSelection){}
            
            Text("Profilee")
            
            Button {
                
                do{
                    try Auth.auth().signOut()
                    singleton.loadData = false
                    self.linkSelection = 1
                    
                }catch let signOutError as NSError{
                    print(#function, "Unable to sign out user : \(signOutError)")
                }
                
            } label: {
                Text("Sign Out")
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: 100)
                    .padding(5)
                    .background(Color(red: 165/255, green: 38/255, blue: 38/255).cornerRadius(10))
            }
        }
    }//body ends
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
