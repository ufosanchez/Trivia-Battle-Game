//
//  TypePokemon.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-05-24.
//

import Foundation

struct TypePokemon : Identifiable{
    var id = UUID()
    var nameType : String = ""
   
    init(){
        self.nameType = "NA"
    }
    
    init(nameType: String) {
        self.nameType = nameType
    }
    
}
