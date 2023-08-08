//
//  SplashView.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-07-20.
//

import SwiftUI

struct SplashView: View {
    @State var isActive : Bool = false
    @State private var opacity = 0.7
    
    var body: some View {
        NavigationView{
            if isActive {
                ContentView()
            } else {
                VStack {
                    VStack {
                        Image("SplashScreen")
                            .resizable()
                            .edgesIgnoringSafeArea(.all)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    }
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.opacity = 1.0
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
