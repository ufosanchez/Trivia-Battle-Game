//
//  Trivia_Battle_GameApp.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-05-28.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

@main
//struct Trivia_Battle_GameApp: App {
//    var body: some Scene {
//        WindowGroup {
////            MainView()
//            Profile()
//        }
//    }
//}

struct Trivia_Battle_GameApp: App {

    let questionHelper = QuestionHelper()

    let fireDBHelper : FireDBHelper
    let fireAuthHelper : FireAuthHelper

    init(){
        FirebaseApp.configure()
        fireDBHelper = FireDBHelper(store: Firestore.firestore())
        fireAuthHelper = FireAuthHelper()
    }

    var body: some Scene {
        WindowGroup {
//            MainView().environmentObject(questionHelper)
            LogInView ().environmentObject(questionHelper).environmentObject(self.fireAuthHelper).environmentObject(self.fireDBHelper)
        }
    }
}
