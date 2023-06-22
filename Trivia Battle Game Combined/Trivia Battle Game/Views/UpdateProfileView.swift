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
                    Text("Username : ")
                        .font(.custom("NerkoOne-Regular", size: 20))
                    TextField("Insert your Username", text: self.$username)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                }
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
                .frame(maxWidth: .infinity)
                
                HStack {
                    Image(systemName: "mail")
                    Text("Email : ")
                        .font(.custom("NerkoOne-Regular", size: 20))
                    Text(self.email)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
            }
            
            HStack{
                HStack {
                    Image(systemName: "calendar")
                    Text("Account created : ")
                        .font(.custom("NerkoOne-Regular", size: 20))
                    Text(self.dateAdded, style: .date)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
                .frame(maxWidth: .infinity)
                
                HStack {
                    Image(systemName: "mail")
                    Text("Days passed : ")
                        .font(.custom("NerkoOne-Regular", size: 20))
                    Text("\(countDays.day ?? 0)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
            }
            
            if(self.changePassword){
                HStack{
                    HStack {
                        Image(systemName: "lock")
                        Text("New Password : ")
                            .font(.custom("NerkoOne-Regular", size: 20))
                        SecureField("New Password", text: self.$newPassword)
                            .textInputAutocapitalization(.never)

                        if(newPassword.count != 0) {
                            Image(systemName: newPassword.count>0 ? "checkmark" : "xmark")
                                .fontWeight(.bold)
                        }
                    }
                    .padding(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))

                    HStack {
                        Image(systemName: "lock")
                        Text("New Password : ")
                            .font(.custom("NerkoOne-Regular", size: 20))
                        SecureField("Confirm Password", text: self.$newConfirmPassword)
                            .textInputAutocapitalization(.never)

                        if(newConfirmPassword.count != 0) {
                            Image(systemName: (newConfirmPassword.count>0 && self.newPassword == self.newConfirmPassword) ? "checkmark" : "xmark")
                                .fontWeight(.bold)
                        }
                    }
                    .padding(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
                }

            }
            
            Toggle("Do you want to change your password?", isOn: self.$changePassword)
                .toggleStyle(iOSCheckboxToggleStyle())
                .foregroundColor(Color.gray)
                .onChange(of: self.changePassword, perform: {_ in
                    print("\(self.changePassword ? "Yes" : "No")")
                })
            
            Button {
                if(!self.username.isEmpty && self.newPassword == self.newConfirmPassword && !self.changePassword){
                    message = "Username updated successfully"
                    showErrorAlert = true
                    flagAlert = false
                }
                else if(!self.username.isEmpty && self.newPassword == self.newConfirmPassword && self.changePassword){
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
                Text("Update Prile")
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: 100)
                    .padding(5)
                    .background(Color.green.cornerRadius(10))
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
