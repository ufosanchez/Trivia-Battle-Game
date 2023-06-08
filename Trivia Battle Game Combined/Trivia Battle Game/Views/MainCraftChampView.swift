//
//  MainView.swift
//  Group6_project
//
//  Created by Winona Lee on 2023-06-06.
//

import SwiftUI

struct MainCraftChampView: View {
    
    private let championInfo : ChampionInfo = ChampionInfo()
    private let index : Index = Index()
    
    @State private var root : RootView = .Champion
    
    var body: some View {
//        NavigationView{
            switch root{
            case .Crafting:
                CraftingView(rootScreen : $root).environmentObject(index)
            case .Champion:
                ChampionView(rootScreen : $root).environmentObject(championInfo).environmentObject(index)
            }
//        }
    }
}

struct MainCraftChampView_Previews: PreviewProvider {
    static var previews: some View {
        MainCraftChampView()
    }
}
