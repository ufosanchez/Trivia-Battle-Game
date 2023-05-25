//
//  Hero.swift
//  Model3D
//
//  Created by Arnulfo Sánchez on 2023-05-23.
//

import Foundation

struct Hero : Identifiable{
    var id = UUID()
    var name : String = ""
    var description : String = ""
    var healt : Int = 0
    var attack : Int = 0
    var dam_type : String = ""
    var ability : String = ""
    var typePokemon = [TypePokemon]()
    
    init() {
        self.name = "NA"
        self.description = "NA"
        self.healt = 0
        self.attack = 0
        self.dam_type = "NA"
        self.ability = "NA"
        self.typePokemon = []
    }
    
    init(name: String, description: String, healt: Int, attack: Int, dam_type: String, ability: String, typePokemon: [TypePokemon] = [TypePokemon]()) {
        self.name = name
        self.description = description
        self.healt = healt
        self.attack = attack
        self.dam_type = dam_type
        self.ability = ability
        self.typePokemon = typePokemon
    }
    
}
