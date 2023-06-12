//
//  Equipment.swift
//  Trivia Battle Game
//
//  Created by Winona Lee on 2023-06-10.

import Foundation
import FirebaseFirestoreSwift

struct Equipment : Codable, Hashable{
    
    @DocumentID var id : String? = UUID().uuidString
    var pWeapon : Int = 0
    var pHelmet : Int = 0
    var pArmor : Int = 0
    var pLegs : Int = 0
    var pBoots : Int = 0
    
    init(){
        
    }
    init(weapon : Int, helmet : Int, armor : Int, legs : Int, boots : Int) {
        self.pWeapon = weapon
        self.pHelmet = helmet
        self.pArmor = armor
        self.pLegs = legs
        self.pBoots = boots 
    }
}
