//
//  Equipment.swift
//  Trivia Battle Game
//
//  Created by Winona Lee on 2023-06-10.

import Foundation
import FirebaseFirestoreSwift

struct Equipment : Codable, Hashable{
    
    @DocumentID var id : String? = UUID().uuidString
    var eWeapon : Int = 0
    var eHelmet : Int = 0
    var eArmor : Int = 0
    var eLegs : Int = 0
    var eBoots : Int = 0
    
    init(){
        
    }
    init(weapon : Int, helmet : Int, armor : Int, legs : Int, boots : Int) {
        self.eWeapon = weapon
        self.eHelmet = helmet
        self.eArmor = armor
        self.eLegs = legs
        self.eBoots = boots
    }
}
