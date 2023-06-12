//
//  MainView.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-05-30.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct MainView: View {
    
    private let fireDBHelper = FireDBHelper.getInstance() ?? FireDBHelper(store: Firestore.firestore())
    
    var body: some View {
//        NavigationView{
            TabView{
//                HeroList().tabItem{
//                    Text("Champion")
//                    Image("Champion")
//                        .renderingMode(.template)
//                }
                MainCraftChampView().environmentObject(fireDBHelper).tabItem{
                    Text("Champion")
                    Image("Champion")
                        .renderingMode(.template)
                }
                Levels().tabItem{
                    Text("Levels")
                    Image("Enemy")
                        .renderingMode(.template)
                }
                Profile().tabItem{
                    Text("Profile")
                    Image(systemName: "person")
                }
            }//TabView ends
            .navigationBarBackButtonHidden(true)
            //        .accentColor(.blue)
//        }//NavigationView ends
    }
}


//struct MainView: View {
//
//    @State private var linkSelection : Int? = nil
//
//    var body: some View {
//        NavigationView{
//
//            VStack{
//                NavigationLink(destination: Profile(), tag: 1, selection: self.$linkSelection){}
//                TabView{
//                    HeroList().tabItem{
//                        Image("Hero")
//                            .renderingMode(.template)
//                    }
//                    Levels().tabItem{
//                        Image("Enemy")
//                            .renderingMode(.template)
//                    }
//                }
//                //        .accentColor(.blue)
//            }
//            .navigationViewStyle(StackNavigationViewStyle())
//            .navigationBarItems(trailing: Button(action : {
//                self.linkSelection = 1
//            }){
//                Image(systemName: "person")
//            })
//        }
//    }
//}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
