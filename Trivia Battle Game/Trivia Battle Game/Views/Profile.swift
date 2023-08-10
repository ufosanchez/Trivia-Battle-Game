//
//  Profile.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-05-30.
//

import SwiftUI
import FirebaseAuth

struct Profile: View {
    
//    let levelUser : Int = 100
//    let totalQuestion : Int = 23
//    let correctQuestion : Int = 17
    
    @State var linkSelection : Int? = nil
    var singleton = Singleton.shared
    
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    @State private var modelList : [String] = ["Widowmaker", "JunkerQueen", "Tracer", "Doomfist"]
    
    let KEY_REMEMBER = "remember"
    
    var body: some View {
        
        VStack(spacing: 5){
            NavigationLink(destination: LogInView(), tag: 1, selection: self.$linkSelection){}
            NavigationLink(destination: UpdateProfileView(), tag: 2, selection: self.$linkSelection){}
            
            Text("Profile")
                .font(.custom("NerkoOne-Regular", size: 35))
                .foregroundColor(.black)
            
            VStack(spacing: 0){
                HexagonView(levelUser: self.fireDBHelper.user.db_Level)
                
                Text(self.fireDBHelper.user.db_Username)
                    .font(.custom("NerkoOne-Regular", size: 30))
                    .foregroundColor(Color(red: 231/255, green: 233/255, blue: 205/255))
                
                HStack{
                    VStack{
                        Text(modelList[self.fireDBHelper.selectedIndex])
                            .font(.custom("NerkoOne-Regular", size: 22))
                            .foregroundColor(.white)
                        Text("Champion")
                            .font(.custom("NerkoOne-Regular", size: 22))
                            .foregroundColor(.black)
                    }
                    
                    Divider()
                        .frame(width: 1, height: 20)
                        .overlay(.black)
                    
                    VStack{
                        Text("\(self.fireDBHelper.user.db_Questions)")
                            .font(.custom("NerkoOne-Regular", size: 22))
                            .foregroundColor(.white)
                        Text("Questions")
                            .font(.custom("NerkoOne-Regular", size: 22))
                            .foregroundColor(.black)
                    }
                    
                    Divider()
                        .frame(width: 1, height: 20)
                        .overlay(.black)
                    
                    VStack{
                        Text("\(self.fireDBHelper.user.db_Games)")
                            .font(.custom("NerkoOne-Regular", size: 22))
                            .foregroundColor(.white)
                        Text("No. Games")
                            .font(.custom("NerkoOne-Regular", size: 22))
                            .foregroundColor(.black)
                    }
                }
                .padding(.bottom, 5)
                
                HStack{
                    VStack(spacing: 5){
                        Text("Correct Answers")
                            .font(.custom("NerkoOne-Regular", size: 22))
                            .foregroundColor(.black)
                        
                        HStack{
                            ZStack(alignment: .leading){
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .frame(width: 100, height: 12)
                                    .foregroundColor(Color.white)
                                
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .frame(width:
                                            self.fireDBHelper.user.db_Questions == 0 ? 0 :
                                            (CGFloat(self.fireDBHelper.user.db_CorrectQuestions*100)/CGFloat(self.fireDBHelper.user.db_Questions)), height: 12)
                                    .foregroundColor(.green)
                            }
                            
                            Text("\(self.fireDBHelper.user.db_Questions == 0 ? 0 : self.fireDBHelper.user.db_CorrectQuestions*100/self.fireDBHelper.user.db_Questions)%")
                                .font(.custom("NerkoOne-Regular", size: 22))
                                .foregroundColor(.black)
                            
                        }
                    }//correct Questions
                    .padding(.vertical, 5)
                    .padding(.horizontal, 50)
                    .background(
                        Color.white.opacity(0.45).cornerRadius(25)
                    )
                    
                    VStack(spacing: 5){
                        Text("Incorrect Answers")
                            .font(.custom("NerkoOne-Regular", size: 22))
                            .foregroundColor(.black)
                        
                        HStack{
                            ZStack(alignment: .leading){
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .frame(width: 100, height: 12)
                                    .foregroundColor(Color.white)
                                
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .frame(width: self.fireDBHelper.user.db_Questions == 0 ? 0 : (CGFloat((self.fireDBHelper.user.db_Questions - self.fireDBHelper.user.db_CorrectQuestions)*100)/CGFloat(self.fireDBHelper.user.db_Questions)), height: 12)
                                    .foregroundColor(.red)
                            }
                            
                            Text("\(self.fireDBHelper.user.db_Questions == 0 ? 0 : ((self.fireDBHelper.user.db_Questions - self.fireDBHelper.user.db_CorrectQuestions)*100)/self.fireDBHelper.user.db_Questions)%")
                                .font(.custom("NerkoOne-Regular", size: 22))
                                .foregroundColor(.black)
                            
                        }
                    }//incorrect Questions
                    .padding(.vertical, 5)
                    .padding(.horizontal, 50)
                    .background(
                        Color.white.opacity(0.45).cornerRadius(25)
                    )
                }
            }// VStack ends
            .frame(width: (UIScreen.screenWidth)/1.5)
            .padding(.vertical, 10)
            .background(
                Color.black.opacity(0.45).cornerRadius(25)
            )
            
            HStack{
                Button {
                    
                    do{
                        try Auth.auth().signOut()
                        singleton.loadData = false
                        UserDefaults.standard.set("NA", forKey: "KEY_EMAIL")
                        UserDefaults.standard.set(false, forKey: KEY_REMEMBER)
                        
                        print("user log out -> \(UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? "No user")")
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
                
                Button {
                    self.linkSelection = 2
                } label: {
                    Text("Update")
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: 100)
                        .padding(5)
                        .background(Color.green.cornerRadius(10))
                }
            }
        }
        .background(
            Image("background1")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        )
        .onAppear{
            self.fireDBHelper.getProfile()
            self.fireDBHelper.getSelectedChampIndex()
            
            print("2 champion number is \(self.fireDBHelper.selectedIndex)")
            print("2 champion name is \(singleton.heroSingleton)")
        }
    }//body ends
}

//struct Profile_Previews: PreviewProvider {
//    static var previews: some View {
//        Profile()
//    }
//}
