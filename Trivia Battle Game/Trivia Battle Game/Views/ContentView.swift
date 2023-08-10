//
//  ContentView.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-07-04.
//

import SwiftUI

struct ContentView: View {
    
    let KEY_REMEMBER = "remember"
    
    @State private var loggedIn = false
    
    var body: some View {
//        NavigationView{
            VStack{
                if loggedIn{
                    MainView()
                }
                else{
                    LogInView()
                }
            }
            .onAppear(){
                self.loggedIn =  UserDefaults.standard.bool(forKey: KEY_REMEMBER)
                print("\(self.loggedIn ? "**Yes" : "**No")")
            }
//        }//NavigationView ends
//        .navigationViewStyle(StackNavigationViewStyle())
    }//body ends
}//ContentView ends

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

