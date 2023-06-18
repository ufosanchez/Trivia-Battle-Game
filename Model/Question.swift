//
//  Question.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-05-30.
//

import Foundation

// --------- Video method
//struct Question : Codable, Identifiable{
//
//    var id = UUID()
//    var category : String
//    var question : String
//    var correct_answer : String
//    var incorrect_answers : [String]
//
//
//}


// --------- Jigisha method
//struct Question : Codable{
//
//    var category : String?
//    var question : String?
//    var correct_answer : String?
//    var incorrect_answers : [String]?
//
//
//    init(){
////        self.results = nil
//        self.category = nil
//        self.question = nil
//        self.correct_answer = nil
//        self.incorrect_answers = nil
//    }
//
//    enum QuestionKeys : CodingKey{
//        case results
//
//        enum ResultsKeys : String, CodingKey{
//            case category
//            case question
//            case correct_answer
//            case incorrect_answers
//        }
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: QuestionKeys.self)
//
//        let currentContainer = try container.nestedContainer(keyedBy: QuestionKeys.ResultsKeys.self, forKey: .results)
//
//        self.category = try currentContainer.decodeIfPresent(String.self, forKey: .category)
//        self.question = try currentContainer.decodeIfPresent(String.self, forKey: .question)
//        self.correct_answer = try currentContainer.decodeIfPresent(String.self, forKey: .correct_answer)
//        self.incorrect_answers = try currentContainer.decodeIfPresent([String].self, forKey: .incorrect_answers)
//    }
//
//}


struct Question : Codable{
    
    var results: [QuestionResponse]?
    
    init(){
        self.results = nil
    }
    
    enum QuestionKeys : CodingKey{
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QuestionKeys.self)
        self.results = try container.decodeIfPresent([QuestionResponse].self, forKey: .results)
    }
    
}

struct QuestionResponse : Codable, Identifiable{
    
    let id = UUID()
    var category : String?
    var question : String?
    var correct_answer : String?
    var incorrect_answers : [String]?

    
    init(){
        self.category = nil
        self.question = nil
        self.correct_answer = nil
        self.incorrect_answers = nil
    }
    
    enum QuestionKeys : String, CodingKey{
        case category
        case question
        case correct_answer
        case incorrect_answers
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QuestionKeys.self)
        self.category = try container.decodeIfPresent(String.self, forKey: .category)
        self.question = try container.decodeIfPresent(String.self, forKey: .question)
        self.correct_answer = try container.decodeIfPresent(String.self, forKey: .correct_answer)
        self.incorrect_answers = try container.decodeIfPresent([String].self, forKey: .incorrect_answers)
    }
    
}


