//
//  FireDBHelper.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-06-07.
//

import Foundation
import FirebaseFirestore

class FireDBHelper : ObservableObject{
    
    @Published var materials = Materials()
    @Published var equipments = Equipment()
    
    private let store : Firestore
    private static var shared : FireDBHelper?
    
    var loggedInUserEmail : String = ""
    
    private let FIELD_CLOTH : String = "pCloth"
    private let FIELD_WOOD : String = "pWood"
    private let FIELD_METAL: String = "pMetal"
    private let FIELD_STONE : String = "pStone"
    
    private let FIELD_WEAPON : String = "pWeapon"
    private let FIELD_HELMET : String = "pHelmet"
    private let FIELD_ARMOR: String = "pArmor"
    private let FIELD_LEGS : String = "pLegs"
    private let FIELD_BOOTS : String = "pBoots"
    
    private let COLLECTION_USER : String = "USER_PROFILE"
    
    init(store: Firestore) {
        self.store = store
    }
    
    static func getInstance() -> FireDBHelper?{
        if (shared == nil){
            shared = FireDBHelper(store: Firestore.firestore())
        }
        
        return shared
    }
    
    
    func getMaterials () {
        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        print("user \(self.loggedInUserEmail)")
        
        let docRef = self.store
            .collection(COLLECTION_USER)
            .document("abc@gmail.com")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                self.materials.pMetal = document["pMetal"] as? Int ?? 0
                self.materials.pWood = document["pWood"] as? Int ?? 0
                self.materials.pStone = document["pStone"] as? Int ?? 0
                self.materials.pCloth = document ["pCloth"] as? Int ?? 0
                
                self.equipments.pWeapon = document["pWeapon"] as? Int ?? 1
                self.equipments.pHelmet = document["pHelmet"] as? Int ?? 1
                self.equipments.pArmor = document["pArmor"] as? Int ?? 1
                self.equipments.pLegs = document["pLegs"] as? Int ?? 1
                self.equipments.pBoots = document["pBoots"] as? Int ?? 1
                
                print("Document data: \(dataDescription)")

            } else {
                print("Document does not exist")
                self.materials.pMetal = 0
                self.materials.pCloth = 0
                self.materials.pWood = 0
                self.materials.pStone = 0
                
                self.equipments.pWeapon = 1
                self.equipments.pArmor = 1
                self.equipments.pHelmet = 1
                self.equipments.pLegs = 1
                self.equipments.pBoots = 1

            }
        }
        
    }
    
    func updateMaterials(materialsToUpdate : Materials, equipmentToUpdate : Equipment){
        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        
        
        let docRef = self.store
            .collection(COLLECTION_USER)
            .document("abc@gmail.com")

        
        docRef.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                    docRef
                    .updateData([FIELD_CLOTH : materialsToUpdate.pCloth,
                              FIELD_METAL : materialsToUpdate.pMetal,
                                FIELD_WOOD: materialsToUpdate.pWood,
                             FIELD_STONE : materialsToUpdate.pStone,
                                FIELD_WEAPON : equipmentToUpdate.pWeapon,
                                FIELD_HELMET : equipmentToUpdate.pHelmet,
                                 FIELD_ARMOR : equipmentToUpdate.pArmor,
                                  FIELD_LEGS : equipmentToUpdate.pLegs,
                                 FIELD_BOOTS : equipmentToUpdate.pBoots]) { error in
                        if let error = error {
                            print(#function, "Unable to update document : \(error)")
                        } else {
                            print(#function, "Successfully update document")
                        }
                    }
            } else {
                print("Document does not exist")
                do {
                    try self.store
                        .collection(COLLECTION_USER)
                        .document(loggedInUserEmail)
                        .setData ([FIELD_CLOTH : materialsToUpdate.pCloth,
                                   FIELD_METAL : materialsToUpdate.pMetal,
                                     FIELD_WOOD: materialsToUpdate.pWood,
                                  FIELD_STONE : materialsToUpdate.pStone,
                                  FIELD_WEAPON : equipmentToUpdate.pWeapon,
                                  FIELD_HELMET : equipmentToUpdate.pHelmet,
                                   FIELD_ARMOR : equipmentToUpdate.pArmor,
                                    FIELD_LEGS : equipmentToUpdate.pLegs,
                                   FIELD_BOOTS : equipmentToUpdate.pBoots])
                } catch let error as NSError {
                    print(#function, "Unable to add document to firestore : \(error)")
                }
            }
        }
        
    }
}
