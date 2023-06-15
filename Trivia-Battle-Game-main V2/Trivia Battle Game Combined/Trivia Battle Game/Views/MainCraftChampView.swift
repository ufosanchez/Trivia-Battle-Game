//
//  MainView.swift
//  Group6_project
//
//  Created by Winona Lee on 2023-06-06.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct MainCraftChampView: View {
    
    private let championInfo : ChampionInfo = ChampionInfo()
    private let index : Index = Index()
    
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    @State private var root : RootView = .Champion
    
    var body: some View {
       VStack{
            switch root{
            case .Crafting:
                CraftingView(rootScreen : $root).environmentObject(index)
            case .Champion:
                ChampionView(rootScreen : $root).environmentObject(championInfo).environmentObject(index)
            }
        }
       .onAppear{
           self.fireDBHelper.getMaterials()
//           self.fireDBHelper.getProfile()
       }
    }

}

struct MainCraftChampView_Previews: PreviewProvider {
    static var previews: some View {
        MainCraftChampView()
    }
}
