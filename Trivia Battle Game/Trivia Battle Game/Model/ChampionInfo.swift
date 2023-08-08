//
//  ChampionInfo.swift
//  Group6_project
//
//  Created by Winona Lee on 2023-05-30.
//

import Foundation

class ChampionInfo : ObservableObject{
    
    var name: String
    var description: String
    var base_health: Int
    var base_attack: Int
    
    init(name: String, description: String, base_health: Int, base_attack: Int) {
        self.name = name
        self.description = description
        self.base_health = base_health
        self.base_attack = base_attack
    }
    
    init(){
        self.name = "NA"
        self.description = "NA"
        self.base_attack = 0
        self.base_health = 0
    }
}
