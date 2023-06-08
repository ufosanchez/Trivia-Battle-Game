//
//  ContentView.swift
//  Group6_project
//
//  Created by Winona Lee on 2023-05-21.
//

import SwiftUI
import SceneKit

struct ChampionView: View {
    
    @State private var currentIndex : Int = 0
    @State private var modelList : [String] = ["Widowmaker", "JunkerQueen"]
    @State private var baseList : [[Int]] = [[30, 10], [10, 30]]
    @State private var description : [String] = ["Widowmaker is the perfect assassin: a patient, ruthlessly efficient killer who shows neither emotion nor remorse. Once, her only two loves were dancing and her husband, but now, her only joy is found in the moment of the kill. An unstoppable killer, Widowmaker’s crosshairs are perhaps the most dangerous place in the world.", "The Junker Queen is the cutthroat leader of the Junkers. The Queen is fierce, resourceful, and no stranger to survival, happy to run headfirst into battle. The Queen is based in Junkertown, and has ruled over her subjects for the last decade."]
                                                 
    @State private var linkSelection : Int? = nil
    
    @EnvironmentObject var championInfo : ChampionInfo
    @EnvironmentObject var index : Index
    
    @Binding var rootScreen : RootView
    
    var body: some View {
        
//        NavigationView{
            HStack {
                NavigationLink(destination: ChampionDetailView().environmentObject(championInfo), tag: 1, selection: self.$linkSelection){}
                //NavigationLink(destination: CraftingView(), tag: 2, selection: self.$linkSelection){}
               
                
                VStack{
                    Text("\(self.modelList[self.currentIndex])").bold()
                    Text("Attack: 20")
                    Text("Health: 15")
                    Button(action: {
                        self.championInfo.name = self.modelList[self.currentIndex]
                        self.championInfo.base_attack = self.baseList[self.currentIndex][0]
                        self.championInfo.base_health = self.baseList[self.currentIndex][1]
                        self.championInfo.description = self.description[currentIndex]
                        
                        self.linkSelection = 1
                    }){
                        Text("Details")
                    }
                    
                }.frame(height: 50)
                    .padding(.trailing, 20)
                
                HStack{
                    Button(action: {
                        if (self.currentIndex >= 1){
                            self.currentIndex -= 1
                        }
                    }){
                        Image(systemName: "arrow.left")
                    }
                    SceneView(scene: {
                        let scene = SCNScene(named: "\(self.modelList[self.currentIndex]).scn")!
                        scene.background.contents = UIColor.systemGray
                        
                        
                        return scene}()
                              ,options: [.autoenablesDefaultLighting, .allowsCameraControl])
                    .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.height-100)
                    
                    Button(action: {
                        if (self.currentIndex < self.modelList.count - 1){
                            self.currentIndex += 1
                        }
                    }){
                        Image(systemName: "arrow.right")
                    }
                }
                

                .padding(.trailing, 20)
                
                VStack {
                        HStack{
                            VStack {
                                VStack{
                            
                                    Button(action: {
                                        self.index.num = 1
                                        self.rootScreen = .Crafting
                                    }){
                                        Image("Helmet").resizable().frame(width: 70, height: 70)
                                    }
                                    //Image("Helmet").resizable().frame(width: 70, height: 70)
                                    Text("Lv. 1")
                                }
                                .padding(.bottom, 10)
                                VStack{
                                    Button(action: {
                                        self.index.num = 2
                                        self.rootScreen = .Crafting
                                    }){
                                        Image("Armor").resizable().frame(width: 70, height: 70)
                                    }
                                    Text("Lv. 1")
                                }
                                .padding(.bottom, 10)
                                VStack{
                                    Button(action: {
                                        self.index.num = 4
                                        self.rootScreen = .Crafting
                                    }){
                                        Image("Boots").resizable().frame(width: 70, height: 70)
                                    }
                                    Text ("Lv. 2")
                                }
                                
                            }
                            .padding(10)
                            VStack {
                                VStack{
                                    Button(action: {
                                        self.index.num = 0
                                        self.rootScreen = .Crafting
                                    }){
                                        Image("Weapon").resizable().frame(width: 70, height: 70)
                                    }
                                    Text("Lv. 3")
                                }
                                .padding(.bottom, 10)
                                VStack{
                                    Button(action: {
                                        self.index.num = 3
                                        self.rootScreen = .Crafting
                                    }){
                                        Image("Legs").resizable().frame(width: 70, height: 70)
                                    }
                                    Text("Lv. 1")
                                }
                            }
                            .padding(20)
                        } //H
                        .padding(.top, 20)
                        
                    Spacer()
                }//V
                Spacer()
            } //H
            .foregroundColor(Color.yellow)
            .background(Color.gray)
            
//        }//NavView
        
        
    }

}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChampionView()
//    }
//}

