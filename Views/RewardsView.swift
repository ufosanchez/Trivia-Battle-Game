//
//  RewardsView.swift
//  Group7_Project
//
//  Created by Winona Lee on 2023-06-11.
//

import SwiftUI

struct RewardsView: View {
    
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    @State private var rewardsArray: [String] = []
    @State private var isButtonClicked = false
    @State private var rewardsCounts = [0, 0, 0, 0]
    
    @State private var linkSelection : Int? = nil
    
    var body: some View {
        NavigationLink(destination: MainView().environmentObject(fireDBHelper), tag: 1, selection: self.$linkSelection){}

        
        VStack {
            Text("Congratulations!").foregroundColor(.blue)
                .font(Font.custom("Baskerville", size: 30)).bold()
            Spacer()
            //                Text("\(self.rewardsArray.joined(separator: ", "))")
            //                   .padding()
            HStack{
                Spacer()
                ForEach(rewardsArray, id: \.self) { filename in
                    Image(filename)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                }
                Spacer()
            }//H
            
            if !isButtonClicked {
                Button(action: {
                    self.rewardsArray = generateRandomArray()
                    self.updateRewardsCounts()
                    self.isButtonClicked = true
                    print(self.rewardsCounts)
                    
                    self.updateMaterials()
                }) {
                    Text("Get Rewards")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }//Button
            } else {
                Button(action: {
                    //Go back to main menu
                    self.linkSelection = 1
                }) {
                    Text("Return to menu")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }//Button
            }
            
        }//V
        .padding(20)
        .background(LinearGradient( colors: [.yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
    }
    
    func generateRandomArray() -> [String] {
        let items = ["Cloth", "Wood", "Metal", "Stone"]
        let size = Int.random(in: 1...3)
        var randomArray: [String] = []
        
        for _ in 0..<size {
            let randomIndex = Int.random(in: 0..<items.count)
            randomArray.append(items[randomIndex])
        }
        
        return randomArray
    }
    func updateRewardsCounts() {
            let items = ["Cloth", "Wood", "Metal", "Stone"]
            rewardsCounts = items.map { item in
                rewardsArray.filter { $0 == item }.count
            }
        }
    func updateMaterials () {
        self.fireDBHelper.materials.mCloth += self.rewardsCounts[0]
        self.fireDBHelper.materials.mWood += self.rewardsCounts[1]
        self.fireDBHelper.materials.mMetal += self.rewardsCounts[2]
        self.fireDBHelper.materials.mStone += self.rewardsCounts[3]
        
        self.fireDBHelper.updateMaterials(materialsToUpdate: self.fireDBHelper.materials, equipmentToUpdate: self.fireDBHelper.equipments)
    }
    
    
}

struct RewardsView_Previews: PreviewProvider {
    static var previews: some View {
        RewardsView()
    }
}
