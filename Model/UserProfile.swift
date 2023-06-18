//
//  UserProfile.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-06-13.
//

import Foundation
import FirebaseFirestoreSwift

struct UserProfile : Codable, Hashable{
    
    @DocumentID var id : String? = UUID().uuidString
    var db_Username : String = ""
    var db_Level : Int = 1
    var db_Questions : Int = 0
    var db_Games : Int = 0
    var db_CorrectQuestions : Int = 0
    var db_dateAdded : Date = Date()
    
    init(){
        
    }
    
    init(username: String){
        self.db_Username = username
    }
    
    init?(dictionary : [String : Any]){
        
        guard let username = dictionary["db_Username"] as? String else{
            print(#function, "Unable to read db_Username from the object")
            return nil
        }
        
        self.init(username: username)
    }
}

