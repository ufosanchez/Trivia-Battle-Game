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
    @Published var user = UserProfile()
    
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
    
    private let FIELD_USERNAME : String = "db_Username"
    private let FIELD_LEVEL : String = "db_Level"
    private let FIELD_QUESTIONS : String = "db_Questions"
    private let FIELD_GAMES : String = "db_Games"
    private let FIELD_CORR_QUESTIONS : String = "db_CorrectQuestions"
    private let FIELD_DATE : String = "db_dateAdded"
    
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
    
    
//    func getMaterials () {
//        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
//        print("user -> \(self.loggedInUserEmail)")
//
//        let docRef = self.store
//            .collection(COLLECTION_USER)
////            .document("abc@gmail.com")
//            .document(loggedInUserEmail)
//
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                self.materials.pMetal = document["pMetal"] as? Int ?? 0
//                self.materials.pWood = document["pWood"] as? Int ?? 0
//                self.materials.pStone = document["pStone"] as? Int ?? 0
//                self.materials.pCloth = document ["pCloth"] as? Int ?? 0
//
//                self.equipments.pWeapon = document["pWeapon"] as? Int ?? 1
//                self.equipments.pHelmet = document["pHelmet"] as? Int ?? 1
//                self.equipments.pArmor = document["pArmor"] as? Int ?? 1
//                self.equipments.pLegs = document["pLegs"] as? Int ?? 1
//                self.equipments.pBoots = document["pBoots"] as? Int ?? 1
//
//                print("Document data: \(dataDescription)")
//
//            } else {
//                print("Document does not exist")
//                self.materials.pMetal = 0
//                self.materials.pCloth = 0
//                self.materials.pWood = 0
//                self.materials.pStone = 0
//
//                self.equipments.pWeapon = 1
//                self.equipments.pArmor = 1
//                self.equipments.pHelmet = 1
//                self.equipments.pLegs = 1
//                self.equipments.pBoots = 1
//
//            }
//        }
//    }
    
    func getMaterials(){
        
        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        print("The user is : \(self.loggedInUserEmail)")
        
        if (loggedInUserEmail.isEmpty){
            print(#function, "Logged in user not identified")
        }
        else{
            self.store
                .collection(COLLECTION_USER)
                .document(loggedInUserEmail)
                .addSnapshotListener { documentSnapshot, error in
                    guard let document = documentSnapshot else {
                        print("Error fetching document: \(error!)")
                        return
                    }
                    guard let data = document.data() else {
                        print("Document data was empty.")
                        return
                    }
                    self.materials.pMetal = data["pMetal"] as? Int ?? 0
                    self.materials.pWood = data["pWood"] as? Int ?? 0
                    self.materials.pStone = data["pStone"] as? Int ?? 0
                    self.materials.pCloth = data ["pCloth"] as? Int ?? 0
                    
                    self.equipments.pWeapon = data["pWeapon"] as? Int ?? 1
                    self.equipments.pHelmet = data["pHelmet"] as? Int ?? 1
                    self.equipments.pArmor = data["pArmor"] as? Int ?? 1
                    self.equipments.pLegs = data["pLegs"] as? Int ?? 1
                    self.equipments.pBoots = data["pBoots"] as? Int ?? 1
                    //                    print("Current data: \(data)")
                    //                    print("Current data: \(data["pWeapon"] as? Int ?? 0)")
                    //                    print("Current data: \(data["db_Username"] as? String ?? "NA")")
                }
        }
    }
    
    func updateMaterials(materialsToUpdate : Materials, equipmentToUpdate : Equipment){
        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        
        
        let docRef = self.store
            .collection(COLLECTION_USER)
        //            .document("abc@gmail.com")
            .document(loggedInUserEmail)
        
        
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
    
    func insertProfile(newUser : UserProfile){
        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        
        if (self.loggedInUserEmail.isEmpty){
            print(#function, "Logged in user not identified")
        }
        else{
            do{
                try self.store
                    .collection(COLLECTION_USER)
                    .document(loggedInUserEmail)
                    .setData ([FIELD_USERNAME : newUser.db_Username,
                                  FIELD_LEVEL : newUser.db_Level,
                              FIELD_QUESTIONS : newUser.db_Questions,
                                  FIELD_GAMES : newUser.db_Games,
                         FIELD_CORR_QUESTIONS : newUser.db_CorrectQuestions,
                                   FIELD_DATE : newUser.db_dateAdded,
                               
                                  FIELD_CLOTH : 0,
                                  FIELD_METAL : 0,
                                    FIELD_WOOD: 0,
                                  FIELD_STONE : 0,
                               
                                 FIELD_WEAPON : 0,
                                 FIELD_HELMET : 0,
                                  FIELD_ARMOR : 0,
                                   FIELD_LEGS : 0,
                                  FIELD_BOOTS : 0])
            }catch let error as NSError{
                print(#function, "Unable to add document to firestore : \(error)")
            }
        }
    }
    
    func getProfile(){
        
        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        print("getUser - The user is : \(self.loggedInUserEmail)")
        
        if (loggedInUserEmail.isEmpty){
            print(#function, "Logged in user not identified")
        }
        else{
            self.store
                .collection(COLLECTION_USER)
                .document(loggedInUserEmail)
                .addSnapshotListener { documentSnapshot, error in
                    guard let document = documentSnapshot else {
                        print("Error fetching document: \(error!)")
                        return
                    }
                    guard let data = document.data() else {
                        print("Document data was empty.")
                        return
                    }
                    self.user.db_Username = data["db_Username"] as? String ?? "NA"
                    self.user.db_Level = data["db_Level"] as? Int ?? 1
                    self.user.db_Questions = data["db_Questions"] as? Int ?? 0
                    self.user.db_Games = data["db_Games"] as? Int ?? 0
                    self.user.db_CorrectQuestions = data ["db_CorrectQuestions"] as? Int ?? 0
                }
        }
    }
    
    func updateDataProfileGame(newLevel : Int, newQuestions : Int, newGames : Int, newCorrectQuestions : Int){
        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        print("getUser - The user is : \(self.loggedInUserEmail)")
        
        if (loggedInUserEmail.isEmpty){
            print(#function, "Logged in user not identified")
        }
        else{
            
            let docRef = self.store
                .collection(COLLECTION_USER)
                .document(loggedInUserEmail)
            
            docRef.getDocument { [self] (document, error) in
                if let document = document, document.exists {
                    docRef
                        .updateData([FIELD_LEVEL : newLevel,
                                 FIELD_QUESTIONS : newQuestions,
                                     FIELD_GAMES : newGames,
                            FIELD_CORR_QUESTIONS : newCorrectQuestions]) { error in
                            if let error = error {
                                print(#function, "Unable to update document : \(error)")
                            } else {
                                print(#function, "Successfully update document")
                            }
                        }
                }
            }
        }
    }
}
