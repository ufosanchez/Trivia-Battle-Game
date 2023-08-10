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
    var mMetal : Int = 0
    var mCloth : Int = 0
    var mWood : Int = 0
    var mStone : Int = 0
    
    init(){
        
    }
    init(metal: Int, cloth: Int, wood: Int, stone: Int){
        self.mMetal = metal
        self.mWood = wood
        self.mCloth = cloth
        self.mStone = stone 
    }
}
