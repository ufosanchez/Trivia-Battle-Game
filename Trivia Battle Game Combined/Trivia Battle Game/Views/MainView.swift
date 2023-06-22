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
//    @EnvironmentObject var notificationHelper : NotificationHelper
    
    var body: some View {
//        NavigationView{
            TabView{
                MainCraftChampView().environmentObject(fireDBHelper).tabItem{
                    Text("Champion")
                    Image("Champion")
                        .renderingMode(.template)
                }
                Levels().environmentObject(fireDBHelper).tabItem{
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
