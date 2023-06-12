//
//  Materials.swift
//  Trivia Battle Game
//
//  Created by Winona Lee on 2023-06-10.
//

import Foundation
import FirebaseFirestoreSwift

struct Materials : Codable, Hashable{
    
    @DocumentID var id : String? = UUID().uuidString
    var pMetal : Int = 0
    var pCloth : Int = 0
    var pWood : Int = 0
    var pStone : Int = 0
    
    init(){
        
    }
    init(metal: Int, cloth: Int, wood: Int, stone: Int){
        self.pMetal = metal
        self.pWood = wood
        self.pCloth = cloth
        self.pStone = stone 
    }
}
