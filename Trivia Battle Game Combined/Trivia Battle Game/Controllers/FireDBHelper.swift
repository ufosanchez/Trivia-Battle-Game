//
//  FireDBHelper.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-06-07.
//

import Foundation
import FirebaseFirestore

class FireDBHelper : ObservableObject{
    
    private let store : Firestore
    
    init(store: Firestore) {
        self.store = store
    }
    
}
