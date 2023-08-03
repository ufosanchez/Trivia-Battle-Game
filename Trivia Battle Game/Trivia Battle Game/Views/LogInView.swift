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
    
    @State private var showErrorAlert : Bool = false
    @State private var message = ""
    
    @State private var remember : Bool = false
    let KEY_REMEMBER = "remember"
    
    var body: some View {
        
//        NavigationView{
            VStack(spacing: 5){
                
                NavigationLink(destination: SignUpView().environmentObject(self.fireDBHelper), tag: 1, selection: self.$linkSelection){}
                NavigationLink(destination: MainView(), tag: 2, selection: self.$linkSelection){}
                
                Text("Trivia Batle Game")
                    .font(.custom("NerkoOne-Regular", size: 35))
                    .foregroundColor(.black)
                
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
                .padding()
                .background(Color.white).cornerRadius(10)
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
                            .foregroundColor(.black)
                        //                        .foregroundColor(isValidPassword(password) ? .green : .red)
                    }
                }
                .padding()
                .background(Color.white).cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
                .padding()
                
                Toggle("Remember Me", isOn: self.$remember)
                    .toggleStyle(iOSCheckboxToggleStyle())
                    .foregroundColor(Color.black)
                    .onChange(of: self.remember, perform: {_ in
                        UserDefaults.standard.set(self.remember, forKey: KEY_REMEMBER)
                        //print("\(self.remember ? "Yes" : "No")")
                    })
                    .padding(.bottom, 5)
                
                
                Button(action: {
                    self.linkSelection = 1
                }) {
                    Text("Create an account?")
//                        .foregroundColor(.black.opacity(0.7))
                        .foregroundColor(.black)
                        .bold()
                }
                .padding(.horizontal, 5)
                .padding(.vertical, 2)
                .background(Color.white).cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
                
                Button {
                    print("trying to logIn")
                    
                    if(!self.email.isEmpty && !self.password.isEmpty){
                        Auth.auth().signIn(withEmail : email, password : password){ [self] authResult, error in
                            
                            guard let result = authResult else{
                                print(#function, "Error while signing up the user : \(error)")
                                message = "Please check your email/password and try again"
                                showErrorAlert = true
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
                                NotificationHelper.instance.requestAuthorization()
                                self.linkSelection = 2
                            }
                            
                        }
                    }else{
                        message = "Please fill all the fields"
                        showErrorAlert = true
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
                .alert(message, isPresented: $showErrorAlert) {
                    Button("OK", role: .cancel) { }
                }
                
                Spacer()
                
                Text("© by Winona Lee and Arnulfo Sánchez")
                    .font(.custom("NerkoOne-Regular", size: 15))
                    .foregroundColor(.black)
            }//VStack ends
            .background(
                Image("background2")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            )
//        }//NavigationView ends
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        
    }//body ends
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
