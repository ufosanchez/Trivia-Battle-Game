//
//  CraftingView.swift
//  Group6_project
//
//  Created by Winona Lee on 2023-05-24.
//

import SwiftUI
import SceneKit

struct CraftingView: View {
    
    @State private var inventory : [Int] = [10, 10, 10, 10]
    @State private var levelList : [Int] = [1, 1, 1, 1, 1]
    @State private var req_materials : [[Int]] = [[3, 5, 7, 5], [3, 2, 3, 4], [2, 3, 5, 4], [3, 1, 4, 3], [5, 1, 1, 2]]
    @State private var err_msg = ""
    @State private var isShowingImage = false
    @State private var rotationAngle: Double = 0
    @State private var currentIndex : Int = 0
    @State private var modelList : [String] = ["Weapon", "Helmet", "Armor", "Legs", "Boots"]
    
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
                    scene.background.contents = UIColor.clear
                    return scene}()
                          ,options: [.autoenablesDefaultLighting, .allowsCameraControl])
                .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height)
                
                if isShowingImage {
                    
                    Image("magic_circle")
                        .frame(width: 100, height: 100)
                        .scaleEffect(0.4)
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
                    
            }
            Button(action: {
                if (self.currentIndex < self.modelList.count){
                    self.currentIndex += 1
                }
            }){
                Image(systemName: "arrow.right")
            }
            
            
            Spacer()
            VStack {
                VStack{
                    Text("\(modelList[currentIndex]) (Lv. \(levelList[currentIndex]))\n").foregroundColor(.white)
                    Button(action: {
                        self.craft()
                    }){
                        Text("LevelUp").bold()
                            .foregroundColor(Color.orange)
                    }
                    .background(Color.green)
                    Text("\(err_msg)").foregroundColor(Color.red)
                }.frame(height: 150)
                
                Spacer()
                
                HStack{
                    
                    VStack{
                        Image("Cloth").resizable().frame(width: 70, height: 70)
                        if(req_materials[currentIndex][0] <= inventory[0]){
                            Text("\(req_materials[currentIndex][0]) (\(inventory[0]))")
                        } else {
                            Text("\(req_materials[currentIndex][0]) (\(inventory[0]))").foregroundColor(Color.red)
                        }
                    }
                    VStack{
                        Image("Wood").resizable().frame(width: 70, height: 70)
                        if(req_materials[currentIndex][1] <= inventory[1]){
                            Text("\(req_materials[currentIndex][1]) (\(inventory[1]))")
                        } else {
                            Text("\(req_materials[currentIndex][1]) (\(inventory[1]))").foregroundColor(Color.red)
                        }
                    }
                }
                HStack{
                    VStack{
                        Image("Metal").resizable().frame(width: 70, height: 70)
                        if(req_materials[currentIndex][2] <= inventory[2]){
                            Text("\(req_materials[currentIndex][2]) (\(inventory[2]))")
                        } else {
                            Text("\(req_materials[currentIndex][2]) (\(inventory[2]))").foregroundColor(Color.red)
                        }
                    }
                    VStack{
                        Image("Stone").resizable().frame(width: 70, height: 70)
                        if(req_materials[currentIndex][3] <= inventory[3]){
                            Text("\(req_materials[currentIndex][3]) (\(inventory[3]))")
                        } else {
                            Text("\(req_materials[currentIndex][3]) (\(inventory[3]))").foregroundColor(Color.red)
                        }
                        
                    }
                    
                } //H
                
                
                
            } //V
            .padding(30)
            Spacer()
        } //H
        .background(Color.gray)
        
        
    }//body
    func craft(){
        if(self.inventory[0] >= self.req_materials[currentIndex][0] && self.inventory[1] >= self.req_materials[currentIndex][1] && self.inventory[2] >= self.req_materials[currentIndex][2] && self.inventory[3] >= self.req_materials[currentIndex][3]){
            self.levelList[currentIndex] += 1
            self.isShowingImage = true
            self.inventory[0] -= req_materials[currentIndex][0]
            self.inventory[1] -= req_materials[currentIndex][1]
            self.inventory[2] -= req_materials[currentIndex][2]
            self.inventory[3] -= req_materials[currentIndex][3]
            
        } else {
            self.err_msg = "Not enough materials"
        }
    }

}

struct CraftingView_Previews: PreviewProvider {
    static var previews: some View {
        CraftingView()
    }
}
