//
//  UpdateProfileView.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-06-21.
//

import SwiftUI
import FirebaseAuth

struct UpdateProfileView: View {
    
    @State private var username : String = ""
    @State private var email : String = ""
    @State private var dateAdded : Date = Date()
    @State private var countDays : DateComponents = DateComponents()
    
    @State private var changePassword : Bool = false
    @State private var newPassword : String = ""
    @State private var newConfirmPassword : String = ""
    
    @State private var showErrorAlert : Bool = false
    @State private var message = ""
    @State private var flagAlert : Bool = false
    
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack{
            HStack{
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.black)
                    Text("Username : ")
                        .font(.custom("NerkoOne-Regular", size: 20))
                        .foregroundColor(.black)
                    TextField("Insert your Username", text: self.$username)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .foregroundColor(.black)
                }
                .padding(10)
                .background(Color.white).cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
                .frame(maxWidth: .infinity)
                
                HStack {
                    Image(systemName: "mail")
                        .foregroundColor(.black)
                    Text("Email : ")
                        .font(.custom("NerkoOne-Regular", size: 20))
                        .foregroundColor(.black)
                    Text(self.email)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.black)
                }
                .padding(10)
                .background(Color.white).cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
            }
            
            HStack{
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.black)
                    Text("Account created : ")
                        .font(.custom("NerkoOne-Regular", size: 20))
                        .foregroundColor(.black)
                    Text(self.dateAdded, style: .date)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.black)
                }
                .padding(10)
                .background(Color.white).cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
                .frame(maxWidth: .infinity)
                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.black)
                    Text("Days passed : ")
                        .font(.custom("NerkoOne-Regular", size: 20))
                        .foregroundColor(.black)
                    Text("\(countDays.day ?? 0)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.black)
                }
                .padding(10)
                .background(Color.white).cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
            }
            
            if(self.changePassword){
                HStack{
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.black)
                        Text("New Password : ")
                            .font(.custom("NerkoOne-Regular", size: 20))
                            .foregroundColor(.black)
                        SecureField("New Password", text: self.$newPassword)
                            .textInputAutocapitalization(.never)
                            .foregroundColor(.black)

                        if(newPassword.count != 0) {
                            Image(systemName: newPassword.count>0 ? "checkmark" : "xmark")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(10)
                    .background(Color.white).cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))

                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.black)
                        Text("New Password : ")
                            .font(.custom("NerkoOne-Regular", size: 20))
                            .foregroundColor(.black)
                        SecureField("Confirm Password", text: self.$newConfirmPassword)
                            .textInputAutocapitalization(.never)
                            .foregroundColor(.black)

                        if(newConfirmPassword.count != 0) {
                            Image(systemName: (newConfirmPassword.count>0 && self.newPassword == self.newConfirmPassword) ? "checkmark" : "xmark")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(10)
                    .background(Color.white).cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
                }

            }
            
            Toggle("Do you want to change your password?", isOn: self.$changePassword)
                .toggleStyle(iOSCheckboxToggleStyle())
                .foregroundColor(Color.black)
                .onChange(of: self.changePassword, perform: {_ in
                    print("\(self.changePassword ? "Yes" : "No")")
                })
            
            Button {
                if(!self.username.isEmpty && self.newPassword == self.newConfirmPassword && !self.changePassword){
                    self.fireDBHelper.updateUsername(newUserName: self.username)
                    message = "Username updated successfully"
                    showErrorAlert = true
                    flagAlert = false
                }
                else if(!self.username.isEmpty && self.newPassword == self.newConfirmPassword && self.changePassword){
                    self.fireDBHelper.updateUsername(newUserName: self.username)
                    Auth.auth().currentUser?.updatePassword(to: self.newPassword) { error in
                        if let error = error {
                            message = error.localizedDescription
                            showErrorAlert = true
                            flagAlert = true
                        }
                        else{
                            message = "Password updated succesfully"
                            showErrorAlert = true
                            flagAlert = false
                        }
                    }
                }
                else{
                    message = "Please fill all the fields correctly"
                    showErrorAlert = true
                    flagAlert = true
                }
            } label: {
                Text("Update Profile")
                    .bold()
                    .foregroundColor(.white)
//                    .frame(maxWidth: 100)
                    .padding(5)
                    .background(Color.black.cornerRadius(10))
            }
            .alert(message, isPresented: $showErrorAlert) {
                if(flagAlert){
                    Button("OK", role: .cancel) { }
                }
                else{
                    Button("OK") { dismiss() }
                }
            }

        }//VStack ends
        .background(
            Image("background3")
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
        .onAppear(){
            self.username = self.fireDBHelper.user.db_Username
            self.email = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
            self.dateAdded = self.fireDBHelper.user.db_dateAdded
            
            countDays = Calendar.current.dateComponents([.day], from: self.dateAdded, to: Date())
        }
    }
}

struct UpdateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfileView()
    }
}

struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                configuration.label
            }
        })
    }
}
