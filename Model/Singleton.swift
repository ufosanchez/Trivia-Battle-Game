//
//  Singleton.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-05-31.
//

import Foundation

class Singleton : ObservableObject {
    
    static let shared = Singleton()
    
    @Published var loadData = false
    
    @Published var healtChampion = 0
    @Published var attackChampion = 0
    
    @Published var questionNumber = 0
    
    @Published var enemySingleton = Enemy(level: 1, name: "Zapdos", description: """
        Zapdos (Japanese: サンダー Thunder) is a dual-type Electric/Flying Legendary Pokémon introduced in Generation I.
        It is not known to evolve into or from any other Pokémon.
        In Galar, Zapdos has a dual-type Fighting/Flying regional form, introduced in The Crown Tundra expansion of the Pokémon Sword and Shield Expansion Pass.
        Along with Articuno and Moltres, it is one of the three Legendary birds of Kanto.
        """, healt: 1000, attack: 100, dam_type: "Electric/Flying Legendary Pokémon", ability: "Lightning Rod", typePokemon: [TypePokemon(nameType: "Fire"), TypePokemon(nameType: "Flying")])
    
}
