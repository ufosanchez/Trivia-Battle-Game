//
//  SignUpView.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-06-07.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    
    @State private var username : String = ""
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var confirmPassword : String = ""
    
    @State var linkSelection : Int? = nil
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    @State private var showErrorAlert : Bool = false
    @State private var message = ""
    
    @State private var remember : Bool = false
    let KEY_REMEMBER = "remember"
    
    var body: some View {
        
        VStack {
            NavigationLink(destination: MainView(), tag: 1, selection: self.$linkSelection){}
            
            Text("Trivia Batle Game")
                .font(.custom("NerkoOne-Regular", size: 35))
                .foregroundColor(.black)
            
            Text("To join the Trivia Battle Game community, please fill out the following form")
                .font(.custom("NerkoOne-Regular", size: 15))
                .foregroundColor(.black.opacity(0.7))
                .foregroundColor(.black)
            
            Spacer()
            
            HStack {
                Image(systemName: "person")
                TextField("Username", text: self.$username)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .foregroundColor(.black)
            }
            .padding(10)
            .background(Color.white).cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
            
            HStack {
                Image(systemName: "mail")
                TextField("Email", text: self.$email)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .foregroundColor(.black)
                
                if(email.count != 0) {
                    Image(systemName: email.count>0 ? "checkmark" : "xmark")
                        .fontWeight(.bold)
                    //                        .foregroundColor(email.count>0 ? .green : .red)
                }
            }
            .padding(10)
            .background(Color.white).cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
            
            HStack{
                HStack {
                    Image(systemName: "lock")
                    SecureField("Password", text: self.$password)
                        .textInputAutocapitalization(.never)
                        .foregroundColor(.black)

                    if(password.count != 0) {
                        Image(systemName: password.count>0 ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                        //                        .foregroundColor(isValidPassword(password) ? .green : .red)
                    }
                }
                .padding(10)
                .background(Color.white).cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))

                HStack {
                    Image(systemName: "lock")
                    SecureField("Confirm Password", text: self.$confirmPassword)
                        .textInputAutocapitalization(.never)
                        .foregroundColor(.black)

                    if(confirmPassword.count != 0) {
                        Image(systemName: (confirmPassword.count>0 && self.password == self.confirmPassword) ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                        //                        .foregroundColor(isValidPassword(password) ? .green : .red)
                    }
                }
                .padding(10)
                .background(Color.white).cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
            }
            
            Toggle("Remember Me", isOn: self.$remember)
                .toggleStyle(iOSCheckboxToggleStyle())
                .foregroundColor(Color.black)
                .onChange(of: self.remember, perform: {_ in
                    UserDefaults.standard.set(self.remember, forKey: KEY_REMEMBER)
                    //print("\(self.remember ? "Yes" : "No")")
                })

            Button {
                
                if(!self.username.isEmpty && !self.email.isEmpty && self.password == self.confirmPassword){
                    Auth.auth().createUser(withEmail : email, password : password){ [self] authResult, error in
                        
                        guard let result = authResult else{
                            message = error?.localizedDescription ?? "Insert Valid email and the password must be at least 6 characters long"
                            showErrorAlert = true
                            return
                        }
                        
                        print(#function, "AuthResult : \(result)")
                        
                        switch authResult{
                        case .none :
                            print(#function, "Unable to create the account")
                        case .some(_) :
                            print(#function, "Succesfully created user account")
                            
                            let newUser = UserProfile(username: self.username)
                            UserDefaults.standard.set(self.email, forKey: "KEY_EMAIL")
                            self.fireDBHelper.insertProfile(newUser: newUser)
                            self.linkSelection = 1
                        }
                    }
                }else{
                    message = "Please fill all the fields correctly"
                    showErrorAlert = true
                }
            } label: {
                
                Text("Create New Account")
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: UIScreen.screenWidth/3)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
            }
            .alert(message, isPresented: $showErrorAlert) {
                Button("OK", role: .cancel) { }
            }
            
//            Spacer()
            
            Text("© by Winona Lee and Arnulfo Sánchez")
                .font(.custom("NerkoOne-Regular", size: 15))
                .foregroundColor(.black)
        }
        .background(
            Image("background2")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        )
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Back  ")
                    }
                    .padding(5)
                    .foregroundColor(Color.white)
                    .background(Color.black.cornerRadius(25))
                }
            }
        }
        
    }//body ends
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

