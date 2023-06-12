//
//  GameView.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-05-12.
//

import SwiftUI
import SceneKit

struct GameView: View {
    
    let selectedEnemy : Enemy
    
    let scene = GameScene(make: true)
    @EnvironmentObject var questionHelper : QuestionHelper
    @State private var questionList = [QuestionResponse]()
    
    @State private var healtChampion = 200
    @State private var healtEnemy = 200
    
    @State private var tapQuestion = true
    
    @State private var message = ""
    @State private var showErrorAlert : Bool = false
    
    var singleton = Singleton.shared
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack{
            
            SceneView(scene: scene, options: .autoenablesDefaultLighting)
                .ignoresSafeArea()
                .alert(isPresented: self.$showErrorAlert){
                    Alert(
                        title: (message == "Congrats you win") ? Text("Congratulations!") : Text("Game Over"),
                        message: (message == "Congrats you win") ?
                        Text("You have defeated \(selectedEnemy.name) and succesfully pased the Level : \(selectedEnemy.level)") : Text("Sorry, you have fallen into the claws of \(selectedEnemy.name), try again"),
                        dismissButton: Alert.Button.default(
                            Text("Go to levels Screen"), action: { dismiss() }
                        )
//                        dismissButton: .default(Text("Go to levels Screen"))
                    )//Alert ends
                }// .alert ends
            
            
            Text("Enemy : \(selectedEnemy.name) - Health : \(healtEnemy) - Champion Health \(healtChampion)")
                .font(.custom("NerkoOne-Regular", size: 18))
            
            VStack{
                //                SceneView(scene: scene, options: .autoenablesDefaultLighting)
                //                    .ignoresSafeArea()
                //
                //                Text("Enemy : \(selectedEnemy.name) - Healt : \(healtEnemy) - Champion Helat \(healtChampion)")
                //                    .font(.custom("NerkoOne-Regular", size: 18))
                
                VStack{
                    if(questionList.count > 0){
                        
                        Text("Category \(questionList[singleton.questionNumber].category ?? "NA") - Question : \(singleton.questionNumber + 1)")
                            .font(.custom("NerkoOne-Regular", size: 18))
                        
                        Text(questionList[singleton.questionNumber].question ?? "NA")
                            .font(.custom("NerkoOne-Regular", size: 18))
                        
                        if(questionList[singleton.questionNumber].incorrect_answers?.count ?? 0 == 2 || questionList[singleton.questionNumber].incorrect_answers?.count ?? 0 == 4){ //check that the correct answer was added to the array of incorrect answers
                            if(questionList[singleton.questionNumber].incorrect_answers?.count ?? 0 > 2){ // multiple answer
                                HStack(spacing: 50){
                                    VStack(alignment: .leading){
                                        Button(action:{
                                            checkAnswer(correct_answer: questionList[singleton.questionNumber].correct_answer ?? "NA", answer_choosed: questionList[singleton.questionNumber].incorrect_answers?[0] ?? "NA")
                                        }){
                                            Text("A. \(questionList[singleton.questionNumber].incorrect_answers?[0] ?? "NA")")
                                                .font(.custom("NerkoOne-Regular", size: 18))
                                        }
                                        
                                        Button(action:{
                                            checkAnswer(correct_answer: questionList[singleton.questionNumber].correct_answer ?? "NA", answer_choosed: questionList[singleton.questionNumber].incorrect_answers?[2] ?? "NA")
                                        }){
                                            Text("C. \(questionList[singleton.questionNumber].incorrect_answers?[2] ?? "NA")")
                                                .font(.custom("NerkoOne-Regular", size: 18))
                                        }
                                    }// VStack ends
                                    VStack(alignment: .leading){
                                        Button(action:{
                                            checkAnswer(correct_answer: questionList[singleton.questionNumber].correct_answer ?? "NA", answer_choosed: questionList[singleton.questionNumber].incorrect_answers?[1] ?? "NA")
                                        }){
                                            Text("B. \(questionList[singleton.questionNumber].incorrect_answers?[1] ?? "NA")")
                                                .font(.custom("NerkoOne-Regular", size: 18))
                                        }
                                        
                                        Button(action:{
                                            checkAnswer(correct_answer: questionList[singleton.questionNumber].correct_answer ?? "NA", answer_choosed: questionList[singleton.questionNumber].incorrect_answers?[3] ?? "NA")
                                        }){
                                            Text("D. \(questionList[singleton.questionNumber].incorrect_answers?[3] ?? "NA")")
                                                .font(.custom("NerkoOne-Regular", size: 18))
                                        }
                                    }// VStack ends
                                }// HStack ends
                            }//if - question is multiple or boolean
                            else{ // true or false answer
                                HStack(spacing: 50){
                                    
                                    Button(action:{
                                        checkAnswer(correct_answer: questionList[singleton.questionNumber].correct_answer ?? "NA", answer_choosed: questionList[singleton.questionNumber].incorrect_answers?[0] ?? "NA")
                                    }){
                                        Text("A. \(questionList[singleton.questionNumber].incorrect_answers?[0] ?? "NA")")
                                            .font(.custom("NerkoOne-Regular", size: 18))
                                    }
                                    
                                    Button(action:{
                                        checkAnswer(correct_answer: questionList[singleton.questionNumber].correct_answer ?? "NA", answer_choosed: questionList[singleton.questionNumber].incorrect_answers?[1] ?? "NA")
                                    }){
                                        Text("B. \(questionList[singleton.questionNumber].incorrect_answers?[1] ?? "NA")")
                                            .font(.custom("NerkoOne-Regular", size: 18))
                                    }
                                }// HStack ends
                            }// if - boolean question
                        }// if - conditional that the correct answer was added to the array of incorrect answers
                    }// if - conditional that check if the API request is completed
                }// VStack ends
                .allowsHitTesting(tapQuestion)
                .padding(10)
                .background(Color(red: 241/255, green: 242/255, blue: 109/255).cornerRadius(25))
                .padding(10)
                .background(Color.black.cornerRadius(25))
                //                .border(Color.pink)
                
                
                //                .frame(maxWidth: .infinity, maxHeight: 130)
                //                .border(Color.blue)
                //                .background(Color.white.edgesIgnoringSafeArea(.all))
                
            }// VStack ends
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            //            .edgesIgnoringSafeArea(.all)
            //            .border(Color.blue)
        }// ZStack ends
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Back  ")
                    }
                    .padding(5)
                    .foregroundColor(Color.white)
                    .background(Color.black.cornerRadius(25))
                }
            }
        }
        //        .background(
        //            Color.black
        //        )
        .onAppear(){
            
            singleton.questionNumber = 0
            
            //try to fetch weather fetchQuestionInfo() function
            self.questionHelper.fetchQuestionInfo( withCompletion: {question in
                print(#function, "onAppear - Question data : \(question)")
                questionList = question?.results ?? []
                print(questionList.count)
                
                
                for itr in  0..<questionList.count{
                    questionList[itr].question = String(htmlEncodedString: questionList[itr].question ?? "NA")//modify HTML string
                    
                    print(questionList[itr].question)
                    
                    questionList[itr].incorrect_answers?.append(questionList[itr].correct_answer ?? "NA") //append answer
                    for itr2 in  0..<(questionList[itr].incorrect_answers?.count ?? 0){
                        print("\(itr) \(questionList[itr].incorrect_answers?[itr2])")
                    }
                    print("--------------------------------------")
                }
            })
        }// onAppear View ends
        
    }// body View ends
    
    func checkAnswer(correct_answer : String , answer_choosed : String){
        if(correct_answer == answer_choosed){//corect answerd choosed
            print("correct answer")
            
            tapQuestion = false
            let fade = SCNAction.fadeOut(duration: 1)
            let move = [SCNAction.move(to: SCNVector3(x: 0, y: 0, z: -3.685), duration: 3),
                        SCNAction.rotate(by: -(.pi), around: SCNVector3(0, 1, 0), duration: 1),
                        SCNAction.move(to: SCNVector3(x: 0, y: 0, z: 5.5 ), duration: 3),
                        SCNAction.rotate(by: .pi, around: SCNVector3(0, 1, 0), duration: 1)]
            
            let sequence = SCNAction.sequence(move)
            
            let moveBadge = [SCNAction.rotate(by: .pi, around: SCNVector3(0, 1, 0), duration: 1),
                        SCNAction.rotate(by: -(.pi), around: SCNVector3(0, 1, 0), duration: 1)]
            
            let sequenceBadge = SCNAction.sequence(moveBadge)
            
//            let actionA = SCNAction.customAction(duration: 3) { (node, elapsedTime) in
//                scene.enemy.runAction(move[0])
//            }
//
//            let actionB = SCNAction.customAction(duration: 1) { (node, elapsedTime) in
//                scene.enemy.runAction(move[1])
//            }
//
//            let sequence3 = SCNAction.sequence([actionA,actionB])
//            scene.enemy.runAction(sequence3)
            
            scene.champion.runAction(sequence) {
                self.healtEnemy = self.healtEnemy - 100

                if(self.healtEnemy <= 0){
                    scene.medal.isHidden = false
                    message = "Congrats you win"
                    self.showErrorAlert = true
                    tapQuestion = false
                    scene.enemy.runAction(fade)//fade enemy
                } else{
                    singleton.questionNumber = singleton.questionNumber + 1
                    tapQuestion = true
                }
            }
        }else{//wrong answerd choosed
            print("wrong answer")
            
            tapQuestion = false
            let fade = SCNAction.fadeOut(duration: 1)
            let move = [SCNAction.move(to: SCNVector3(x: 0, y: 0, z: 3.685), duration: 3),
                        SCNAction.rotate(by: .pi, around: SCNVector3(0, 1, 0), duration: 1),
                        SCNAction.move(to: SCNVector3(x: 0, y: 0, z: -5.465 ), duration: 3),
                        SCNAction.rotate(by: -(.pi), around: SCNVector3(0, 1, 0), duration: 1)]
            
            let sequence = SCNAction.sequence(move)
            
            scene.enemy.runAction(sequence) {
                self.healtChampion = self.healtChampion - 100
                
                if(self.healtChampion <= 0){
                    message = "Sorry you lose"
                    self.showErrorAlert = true
                    tapQuestion = false
                    scene.champion.runAction(fade)//fade enemy
                } else{
                    singleton.questionNumber = singleton.questionNumber + 1
                    tapQuestion = true
                }
            }
        }
    }// checkAnswer ends
}// GameView View ends

extension String {
    
    init?(htmlEncodedString: String) {
        
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        
        self.init(attributedString.string)
        
    }
    
}

//struct ButtonAnswerView : View{
//
//    var answer : String
//    var healtEnemy : Int
//
//    var body : some View{
//
//        Button(action:{
//            healtEnemy = healtEnemy - 100
//        }){
//            Text("A. \(answer)")
//        }
//    }
//}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}

