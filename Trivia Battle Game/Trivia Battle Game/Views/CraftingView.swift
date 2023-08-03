//
//  CraftingView.swift
//  Group6_project
//
//  Created by Winona Lee on 2023-05-24.
//

import SwiftUI
import SceneKit

struct CraftingView: View {
    
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    @State private var inventory : [Int] = [20, 20, 20, 20]
    @State private var levelList : [Int] = [1, 1, 1, 1, 1]
    @State private var req_materials : [[Int]] = [[3, 5, 7, 5], [3, 2, 3, 4], [2, 3, 5, 4], [3, 1, 4, 3], [5, 1, 1, 2]]
    @State private var err_msg = ""
    @State private var isShowingImage = false
    @State private var rotationAngle: Double = 0
    @State private var currentIndex : Int = 0
    @State private var modelList : [String] = ["Weapon", "Helmet", "Armor", "Legs", "Boots"]
    
    
    @EnvironmentObject var index : Index
    @Binding var rootScreen : RootView
    
    var body: some View {
       
        HStack {
            Button(action: {
                if (self.currentIndex >= 1){
                    self.currentIndex -= 1
                }
            }){
                Image(systemName: "arrow.left")
            }
            
            ZStack{
                SceneView(scene: {
                    let scene = SCNScene(named: "\(self.modelList[currentIndex]).scn")!
                    
                    let backgroundImage = UIImage(named: "craftingBackground.png")
                    scene.background.contents = backgroundImage
                    
         
                    return scene}()
                          ,options: [.autoenablesDefaultLighting, .allowsCameraControl])
//                .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height)
                .frame(width: UIScreen.main.bounds.width/2, height: (UIScreen.screenHeight - 100))
//                .padding(.top, 20)
                
                if isShowingImage {
                    
                    Image("magic_circle")
                        .frame(width: 100, height: 100)
                        .scaleEffect(0.3)
                        .rotationEffect(.degrees(rotationAngle))
                        .animation(.linear(duration: 2))
                        .onAppear {
                            withAnimation {
                                rotationAngle = 360
                            }
                            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                                withAnimation {
                                    rotationAngle = 0
                                }
                                isShowingImage = false
                            }
                        }
                }
                
                Button(action: {
                    self.rootScreen = .Champion
                }){
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Back  ")
                    }
                    .padding(5)
                    .foregroundColor(Color.white)
                    .background(Color.black.cornerRadius(25))
                    
                    .padding(.top, 2)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }//Z

            Button(action: {
                if (self.currentIndex < self.modelList.count - 1){
                    self.currentIndex += 1
                }
            }){
                Image(systemName: "arrow.right")
            }
            
            
            Spacer()
            VStack {
                VStack{
                    Text("\(self.modelList[self.currentIndex]) (Lv. \(self.levelList[self.currentIndex]))\n")
                        .foregroundColor(.white)
                        .font(Font.custom("Baskerville", size: 24)).bold()
                    Button(action: {
                        self.craft()
                    }){
                        Text("LevelUp").bold()
                            .foregroundColor(Color.orange)
                    }
                    .padding(5)
                    .background(Color(red: 0, green: 0.5, blue: 0))
                    .foregroundColor(.yellow)
                    .clipShape(Capsule())
                    Text("\(err_msg)").foregroundColor(Color.red)
                }
//                .frame(height: 150)
//                .padding(.top, 20)
                
//                Spacer()
                
                HStack{
                    
                    VStack{
                        Image("Cloth").resizable().frame(width: 70, height: 70)
                        if(self.req_materials[self.currentIndex][0] <= self.inventory[0]){
                            Text("\(self.req_materials[self.currentIndex][0]) (\(self.inventory[0]))")
                        } else {
                            Text("\(self.req_materials[self.currentIndex][0]) (\(self.inventory[0]))").foregroundColor(Color.red)
                        }
                    }
                    VStack{
                        Image("Wood").resizable().frame(width: 70, height: 70)
                        if(self.req_materials[self.currentIndex][1] <= self.inventory[1]){
                            Text("\(self.req_materials[self.currentIndex][1]) (\(inventory[1]))")
                        } else {
                            Text("\(self.req_materials[self.currentIndex][1]) (\(self.inventory[1]))").foregroundColor(Color.red)
                        }
                    }
                }//H
                HStack{
                    VStack{
                        Image("Metal").resizable().frame(width: 70, height: 70)
                        if(self.req_materials[self.currentIndex][2] <= self.inventory[2]){
                            Text("\(self.req_materials[self.currentIndex][2]) (\(self.inventory[2]))")
                        } else {
                            Text("\(self.req_materials[self.currentIndex][2]) (\(self.inventory[2]))").foregroundColor(Color.red)
                        }
                    }
                    VStack{
                        Image("Stone").resizable().frame(width: 70, height: 70)
                        if(self.req_materials[self.currentIndex][3] <= self.inventory[3]){
                            Text("\(self.req_materials[self.currentIndex][3]) (\(self.inventory[3]))")
                        } else {
                            Text("\(self.req_materials[self.currentIndex][3]) (\(self.inventory[3]))").foregroundColor(Color.red)
                        }
                        
                    }
                    
                } //H
                
                
                
            } //V
//            .padding(30)
            Spacer()
        } //H
        .frame(maxHeight: UIScreen.screenHeight)
        .background(LinearGradient( colors: [.green, .brown], startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all))
        .onAppear{
            self.currentIndex = self.index.num
            
            self.inventory[0] = self.fireDBHelper.materials.mCloth
            self.inventory[1] = self.fireDBHelper.materials.mWood
            self.inventory[2] = self.fireDBHelper.materials.mMetal
            self.inventory[3] = self.fireDBHelper.materials.mStone
            
            self.levelList[0] = self.fireDBHelper.equipments.eWeapon
            self.levelList[1] = self.fireDBHelper.equipments.eHelmet
            self.levelList[2] = self.fireDBHelper.equipments.eArmor
            self.levelList[3] = self.fireDBHelper.equipments.eLegs
            self.levelList[4] = self.fireDBHelper.equipments.eBoots
        }

        
        
    }//body
    func craft(){
        if(self.inventory[0] >= self.req_materials[self.currentIndex][0] && self.inventory[1] >= self.req_materials[self.currentIndex][1] && self.inventory[2] >= self.req_materials[self.currentIndex][2] && self.inventory[3] >= self.req_materials[self.currentIndex][3]){
            self.levelList[self.currentIndex] += 1
            self.isShowingImage = true
            self.inventory[0] -= self.req_materials[self.currentIndex][0]
            self.inventory[1] -= self.req_materials[self.currentIndex][1]
            self.inventory[2] -= self.req_materials[self.currentIndex][2]
            self.inventory[3] -= self.req_materials[self.currentIndex][3]
            
            
            self.fireDBHelper.materials.mCloth = self.inventory[0]
            self.fireDBHelper.materials.mWood = self.inventory[1]
            self.fireDBHelper.materials.mMetal = self.inventory[2]
            self.fireDBHelper.materials.mStone = self.inventory[3]
            
            self.fireDBHelper.equipments.eWeapon = self.levelList[0]
            self.fireDBHelper.equipments.eHelmet = self.levelList[1]
            self.fireDBHelper.equipments.eArmor = self.levelList[2]
            self.fireDBHelper.equipments.eLegs = self.levelList[3]
            self.fireDBHelper.equipments.eBoots = self.levelList[4]
            
            self.fireDBHelper.updateMaterials(materialsToUpdate: self.fireDBHelper.materials, equipmentToUpdate: self.fireDBHelper.equipments)
            
        } else {
            self.err_msg = "Not enough materials"
        }
    }
}

//struct CraftingView_Previews: PreviewProvider {
//    static var previews: some View {
//        CraftingView()
//    }
//}
