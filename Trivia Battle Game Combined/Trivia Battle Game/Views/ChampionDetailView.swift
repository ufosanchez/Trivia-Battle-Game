//
//  ChampionDetailView.swift
//  Group6_project
//
//  Created by Winona Lee on 2023-05-30.
//

import SwiftUI
import SceneKit

struct ChampionDetailView: View {
    
    @EnvironmentObject var championInfo : ChampionInfo
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack{
            SceneView(scene: {
                let scene = SCNScene(named: "\(self.championInfo.name).scn")!
                scene.background.contents = UIColor.systemGray
                return scene}()
                      ,options: [.autoenablesDefaultLighting, .allowsCameraControl])
            .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.height)
            .padding(.bottom, 10)
            
            VStack{
                Text("Champion Name: \(self.championInfo.name)")
                    .font(Font.custom("Baskerville", size: 24)).bold()
                Text("Base Attack: \(self.championInfo.base_attack)")
                Text("Base Health: \(self.championInfo.base_health)")
                Text("Description: \(self.championInfo.description)")
            }
        }
        .foregroundColor(Color.yellow)
        .background(Color.gray)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Back  ")
                    }
                    .padding(5)
                    .foregroundColor(Color.white)
                    .background(Color.black.cornerRadius(25))
                }
            }
        }
        
    }
}

struct ChampionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChampionDetailView()
    }
}
