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
    @State private var modelList : [String] = ["Widowmaker", "JunkerQueen", "Tracer", "Doomfist"]
    @State private var baseList : [[Int]] = [[30, 10], [10, 30], [20, 20], [15, 25]]
    @State private var description : [String] = ["Widowmaker is the perfect assassin: a patient, ruthlessly efficient killer who shows neither emotion nor remorse. Once, her only two loves were dancing and her husband, but now, her only joy is found in the moment of the kill. An unstoppable killer, Widowmaker’s crosshairs are perhaps the most dangerous place in the world.", "The Junker Queen is the cutthroat leader of the Junkers. The Queen is fierce, resourceful, and no stranger to survival, happy to run headfirst into battle. The Queen is based in Junkertown, and has ruled over her subjects for the last decade.", "The former Overwatch agent known as Tracer is a time-jumping adventurer and an irrepressible force for good. She hails from London, and has traveled all over the world. With her irrepressible energy and boundless idealism, Tracer inspires her team—and all who know her—to fight for a better future.", "A highly trained fighter and born leader, Doomfist is determined to plunge the world into a new conflict that he believes will make humanity stronger. In Doomfist's view, the global order is unjust, created \"to protect criminals from the division they create.\" In his mind, the solution is to tear it down. He is aware that his actions have cost countless lives, but by his calculus, he has saved many more."]
                                                 
    @State private var linkSelection : Int? = nil
    
    @EnvironmentObject var championInfo : ChampionInfo
    @EnvironmentObject var index : Index
    
    @Binding var rootScreen : RootView
    
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    var body: some View {
        
//        NavigationView{
            HStack {
                NavigationLink(destination: ChampionDetailView().environmentObject(championInfo), tag: 1, selection: self.$linkSelection){}
                //NavigationLink(destination: CraftingView(), tag: 2, selection: self.$linkSelection){}
               
                Spacer()
                VStack{
                    Text("\(self.modelList[self.currentIndex])").font(Font.custom("Baskerville", size: 18)).bold()
                    Text("Attack: \(self.baseList[currentIndex][0] + (self.fireDBHelper.equipments.pWeapon * 10))").font(Font.custom("Baskerville", size: 18))
                    Text("Health: \(self.baseList[currentIndex][1] + (self.fireDBHelper.equipments.pHelmet * 5) + (self.fireDBHelper.equipments.pArmor * 5) + (self.fireDBHelper.equipments.pLegs * 5) + (self.fireDBHelper.equipments.pBoots * 5))").font(Font.custom("Baskerville", size: 18))
                    Button(action: {
                        self.championInfo.name = self.modelList[self.currentIndex]
                        self.championInfo.base_attack = self.baseList[self.currentIndex][0]
                        self.championInfo.base_health = self.baseList[self.currentIndex][1]
                        self.championInfo.description = self.description[currentIndex]
                        
                        self.linkSelection = 1
                    }){
                        Text("Details")
                    }
                    .padding(5)
                    .background(Color(red: 0.5, green: 0.5, blue: 0))
                    .foregroundColor(.red)
                    .clipShape(Capsule())
                    
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
                        
                        scene.background.contents = UIColor.clear
                        
                        let backgroundImage = UIImage(named: "Character_background.jpg")
                        scene.background.contents = backgroundImage
                        
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
                                    Text("Lv. \(self.fireDBHelper.equipments.pHelmet)").font(Font.custom("Baskerville", size: 15)).bold()
                                }
                                .padding(.bottom, 10)
                                VStack{
                                    Button(action: {
                                        self.index.num = 2
                                        self.rootScreen = .Crafting
                                    }){
                                        Image("Armor").resizable().frame(width: 70, height: 70)
                                    }
                                    Text("Lv. \(self.fireDBHelper.equipments.pArmor)").font(Font.custom("Baskerville", size: 15)).bold()
                                }
                                .padding(.bottom, 10)
                                VStack{
                                    Button(action: {
                                        self.index.num = 4
                                        self.rootScreen = .Crafting
                                    }){
                                        Image("Boots").resizable().frame(width: 70, height: 70)
                                    }
                                    Text ("Lv. \(self.fireDBHelper.equipments.pBoots)").font(Font.custom("Baskerville", size: 15)).bold()
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
                                    Text("Lv. \(self.fireDBHelper.equipments.pWeapon)").font(Font.custom("Baskerville", size: 15)).bold()
                                }
                                .padding(.bottom, 10)
                                VStack{
                                    Button(action: {
                                        self.index.num = 3
                                        self.rootScreen = .Crafting
                                    }){
                                        Image("Legs").resizable().frame(width: 70, height: 70)
                                    }
                                    Text("Lv. \(self.fireDBHelper.equipments.pLegs)").font(Font.custom("Baskerville", size: 15)).bold()
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
            .background(LinearGradient( colors: [.black, .gray], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all))
            
//        }//NavView
        
        
    }

}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChampionView()
//    }
//}

