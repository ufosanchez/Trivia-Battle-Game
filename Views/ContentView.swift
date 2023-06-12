//
//  ContentView.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-05-12.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    
    let scene = GameScene(make: true)
    var body: some View {
        ZStack{
            SceneView(scene: scene, options: .autoenablesDefaultLighting)
                .ignoresSafeArea()
//            Text("aaa")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
