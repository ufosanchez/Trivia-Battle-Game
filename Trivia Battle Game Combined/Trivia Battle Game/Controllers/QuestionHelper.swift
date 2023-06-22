//
//  QuestionHelper.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-05-30.
//

import Foundation

class QuestionHelper : ObservableObject{
    
    @Published var questionInfo = Question()
    
    private let apiURL = "https://opentdb.com/api.php?amount=50&difficulty=easy"
    
    func fetchQuestionInfo(withCompletion completion: @escaping (Question?) -> Void) {
        
        guard let api = URL(string: apiURL) else{
            print(#function, "Unable to convert string to URL")
            return
        }
        
        //create a task to connect to network and extract the data
        let task = URLSession.shared.dataTask(with: api){ (data: Data?, response : URLResponse?, error : Error?) in
            
            if let error = error{
                print(#function, "Error while connecting to network \(error)")
            }else{
                if let httpResponse = response as? HTTPURLResponse{
                    
                    if (httpResponse.statusCode == 200){
                        //execute background asynchronous task to decode the response
                        DispatchQueue.global().async {
                            do{
                                if (data != nil){
                                    if let jsonData = data{
                                        
                                        let jsondecoder = JSONDecoder()
                                        var questionResponse = try jsondecoder.decode(Question.self, from: jsonData) as Question
                                        
                                        print(#function, "Question Info Received \(questionResponse)")
                                        
                                        //return to main thread to access UI
                                        DispatchQueue.main.async {
                                            self.questionInfo = questionResponse
                                            completion(questionResponse)
                                        }
                                        
                                    }else{
                                        print(#function, "Unable to get the JSON data")
                                    }
                                }else{
                                    print(#function, "Response received without data")
                                }
                            }catch let error{
                                print(#function, "Error while extracting data : \(error)")
                            }
                        }
                    } else{
                        print(#function, "Unsuccessful response. Response Code : \(httpResponse.statusCode)")
                    }
                    
                } else{
                    print(#function, "Unable to get HTTP Response")
                }
            }
            
        }
        
        //execute the task
        task.resume()
        
    }
}
