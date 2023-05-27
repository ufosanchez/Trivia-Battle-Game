//
//  ContentView.swift
//  Group6_project
//
//  Created by Winona Lee on 2023-05-21.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    var body: some View {
        ZStack {
            SceneView(scene: {
                let scene = SCNScene(named: "Widowmaker.scn")!
                scene.background.contents = UIColor.systemGray
                return scene}()
                      ,options: [.autoenablesDefaultLighting, .allowsCameraControl])
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
            
            VStack {
                VStack{
                    Text("Attack: 20")
                    Text("Health: 15")
                }.frame(height: 150)
                HStack{
                    VStack {
                        VStack{
                            Image("Helmet").resizable().frame(width: 70, height: 70)
                            Text("Lv. 1")
                        }
                        .padding(.bottom, 70)
                        VStack{
                            Image("Armor").resizable().frame(width: 70, height: 70)
                            Text("Lv. 1")
                        }
                            .padding(.bottom, 70)
                        VStack{
                            Image("Boots").resizable().frame(width: 70, height: 70)
                            Text ("Lv. 2")
                        }
                        
                    }
                    .padding(20)
                    Spacer()
                    VStack {
                        VStack{
                            Image("Weapon").resizable().frame(width: 70, height: 70)
                            Text("Lv. 3")
                        }
                            .padding(.bottom, 70)
                        VStack{
                            Image("Legs").resizable().frame(width: 70, height: 70)
                            Text("Lv. 1")
                        }
                    }
                    .padding(20)
                } //H
            Spacer()
            } //V
        } //Z
        .foregroundColor(Color.yellow)
        .background(Color.gray)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

