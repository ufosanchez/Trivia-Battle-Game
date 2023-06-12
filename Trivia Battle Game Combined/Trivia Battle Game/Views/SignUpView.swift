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
    
    var body: some View {
        
        VStack {
            NavigationLink(destination: MainView(), tag: 1, selection: self.$linkSelection){}
            
            Text("Trivia Batle Game")
                .font(.custom("NerkoOne-Regular", size: 35))
            
            Text("To join the Trivia Battle Game community, please fill out the following form")
                .font(.custom("NerkoOne-Regular", size: 15))
                .foregroundColor(.black.opacity(0.7))
            
            Spacer()
            
            HStack {
                Image(systemName: "person")
                TextField("Username", text: self.$username)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
            }
            .padding(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
            
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
            .padding(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
            
            HStack{
                HStack {
                    Image(systemName: "lock")
                    SecureField("Password", text: self.$password)
                        .textInputAutocapitalization(.never)

                    if(password.count != 0) {
                        Image(systemName: password.count>0 ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                        //                        .foregroundColor(isValidPassword(password) ? .green : .red)
                    }
                }
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))

                HStack {
                    Image(systemName: "lock")
                    SecureField("Confirm Password", text: self.$confirmPassword)
                        .textInputAutocapitalization(.never)

                    if(confirmPassword.count != 0) {
                        Image(systemName: confirmPassword.count>0 ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                        //                        .foregroundColor(isValidPassword(password) ? .green : .red)
                    }
                }
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
            }

            Button {
                
                if(!self.username.isEmpty && !self.email.isEmpty && self.password == self.confirmPassword){
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
                            self.linkSelection = 1
    //                        UserDefaults.standard.set(self.user?.email, forKey: "KEY_EMAIL")
                        }
                    }
                }
                else{
                    print("fill all the data correctly")
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
            
            Spacer()
            
            Text("© by Winona Lee and Arnulfo Sánchez")
                .font(.custom("NerkoOne-Regular", size: 15))
        }
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


//NavigationView{
//    VStack{
//        NavigationLink(destination: MainView(), tag: 1, selection: self.$linkSelection){}
//
//        Form{
//
//            TextField("Enter Email", text: self.$email)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .autocapitalization(.none)
//
//            SecureField("Enter Password", text: self.$password)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .autocapitalization(.none)
//
//            SecureField("Enter Password Again", text: self.$confirmPassword)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .autocapitalization(.none)
//
//        }//Form ends
//        .disableAutocorrection(true)
//
//        Section{
//            Button(action : {
//                //validate the data
//                //such as all inputs are not empty
//                //and check for password rule
//                //and display alert accordingly
//
//                //if all data is validated
//                self.fireAuthHelper.signUp(email: self.email, password: self.password)
//                print("aaaa")
//            }){
//                Text("Create Account")
//            }//Button ends
//            .disabled(self.password != self.confirmPassword && self.email.isEmpty && self.password.isEmpty && self.confirmPassword.isEmpty)
//
//        }
//
//    }//Vstack ends
//}//NavigationView ends



//struct SignUpView: View {
//
//    @EnvironmentObject var fireAuthHelper : FireAuthHelper
//
//    @State private var email : String = ""
//    @State private var confirmEmail : String = ""
//    @State private var password : String = ""
//    @State private var confirmPassword : String = ""
//
//    @State var linkSelection : Int? = nil
//
//    @Environment(\.dismiss) private var dismiss
//
//    var body: some View {
//
//        VStack {
//            NavigationLink(destination: MainView(), tag: 1, selection: self.$linkSelection){}
//
//            Text("Trivia Batle Game")
//                .font(.custom("NerkoOne-Regular", size: 25))
//
//            VStack(spacing: 15){
//                HStack{
//                    HStack {
//                        Image(systemName: "mail")
//                        TextField("Email", text: self.$email)
//                            .textInputAutocapitalization(.never)
//
//                        if(email.count != 0) {
//                            Image(systemName: email.count>0 ? "checkmark" : "xmark")
//                                .fontWeight(.bold)
//                            //                        .foregroundColor(email.count>0 ? .green : .red)
//                        }
//                    }
//                    .padding(10)
//                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
//
//                    HStack {
//                        Image(systemName: "mail")
//                        TextField("Confirm Email", text: self.$confirmEmail)
//                            .textInputAutocapitalization(.never)
//
//                        if(confirmEmail.count != 0) {
//                            Image(systemName: email.count>0 ? "checkmark" : "xmark")
//                                .fontWeight(.bold)
//                            //                        .foregroundColor(email.count>0 ? .green : .red)
//                        }
//                    }
//                    .padding(10)
//                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
//                }
//
//                HStack{
//                    HStack {
//                        Image(systemName: "lock")
//                        SecureField("Password", text: self.$password)
//                            .textInputAutocapitalization(.never)
//
//                        if(password.count != 0) {
//                            Image(systemName: password.count>0 ? "checkmark" : "xmark")
//                                .fontWeight(.bold)
//                            //                        .foregroundColor(isValidPassword(password) ? .green : .red)
//                        }
//                    }
//                    .padding(10)
//                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
//
//                    HStack {
//                        Image(systemName: "lock")
//                        SecureField("Confirm Password", text: self.$confirmPassword)
//                            .textInputAutocapitalization(.never)
//
//                        if(password.count != 0) {
//                            Image(systemName: password.count>0 ? "checkmark" : "xmark")
//                                .fontWeight(.bold)
//                            //                        .foregroundColor(isValidPassword(password) ? .green : .red)
//                        }
//                    }
//                    .padding(10)
//                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
//                }
//            }
//
//            Button {
//
//                if(self.email == self.confirmEmail && self.password == self.confirmPassword){
//                    Auth.auth().createUser(withEmail : email, password : password){ [self] authResult, error in
//
//                        guard let result = authResult else{
//                            print(#function, "Error while signing up the user : \(error)")
//                            return
//                        }
//
//                        print(#function, "AuthResult : \(result)")
//
//                        switch authResult{
//                        case .none :
//                            print(#function, "Unable to create the account")
//                        case .some(_) :
//                            print(#function, "Succesfully created user account")
//                            self.linkSelection = 1
//
//    //                        UserDefaults.standard.set(self.user?.email, forKey: "KEY_EMAIL")
//                        }
//                    }
//                }
//
//            } label: {
//
//                Text("Create New Account")
//                    .foregroundColor(.white)
//                    .font(.title3)
//                    .bold()
//                    .frame(maxWidth: UIScreen.screenWidth/3)
//                    .padding()
//                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
//            }
//
//            Spacer()
//
//            Text("© by Winona Lee and Arnulfo Sanchez")
//                .font(.custom("NerkoOne-Regular", size: 15))
//        }
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    dismiss()
//                } label: {
//                    HStack {
//                        Image(systemName: "chevron.backward")
//                        Text("Back  ")
//                    }
//                    .padding(5)
//                    .foregroundColor(Color.white)
//                    .background(Color.black.cornerRadius(25))
//                }
//            }
//        }
//
//    }//body ends
//}

