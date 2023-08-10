//
//  Index.swift
//  Group6_project
//
//  Created by Winona Lee on 2023-06-06.
//

import Foundation

class Index : ObservableObject{
    var num : Int
    
    init(num: Int) {
        self.num = num
    }
    init (){
        self.num = 0
    }
}
