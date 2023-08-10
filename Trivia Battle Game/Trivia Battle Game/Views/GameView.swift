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
    
    @State private var healtChampion = 0
    @State private var healtTotalChampion = 2000
    @State private var attackChampion = 100
    
    @State private var healtEnemy = 0
//    @State private var attackEnemy = 0
    
    @State private var tapQuestion = true
    
    @State private var message = ""
    @State private var showErrorAlert : Bool = false
    
    @State private var linkSelection : Int? = nil
    
    var singleton = Singleton.shared
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    @State private var correctAnswers = 0
    
    var body: some View {
        ZStack{
            
            NavigationLink(destination: RewardsView().environmentObject(fireDBHelper), tag: 1, selection: self.$linkSelection){}
            
            SceneView(scene: scene, options: .autoenablesDefaultLighting)
                .ignoresSafeArea()
                .alert(isPresented: self.$showErrorAlert){
                    Alert(
                        title: (message == "Congrats you win") ? Text("Congratulations!") : Text("Game Over"),
                        message: (message == "Congrats you win") ?
                        Text("You have defeated \(selectedEnemy.name) and succesfully passed the Level : \(selectedEnemy.level)") : Text("Sorry, you have fallen into the claws of \(selectedEnemy.name), try again"),
                        dismissButton: (message == "Congrats you win") ? Alert.Button.default( Text("Go to Rewards Screen"), action: { self.linkSelection = 1 }) : Alert.Button.default( Text("Go to levels Screen"), action: { dismiss() })
//                        dismissButton: .default(Text("Go to levels Screen"))
                    )//Alert ends
                }// .alert ends
            
            HStack{
                VStack{
                    VStack{
                        HStack{
                            Text(singleton.heroSingleton.capitalized)
                                .font(.custom("PressStart2P-Regular", size: 9))
                                .padding(.trailing, 15)
                                .foregroundColor(.black)
                            
                            Image("Enemy")
                                .resizable()
                                .frame(width: 15, height: 15)
                            Text("\(singleton.attackChampion)")
                                .font(.custom("PressStart2P-Regular", size: 9))
                                .foregroundColor(.black)
                        }
                        
                        HStack{
                            HStack{
                                Text("HP")
                                    .font(.custom("PressStart2P-Regular", size: 9))
                                    .foregroundColor(Color.yellow)
                                
                                ZStack(alignment: .leading){
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .frame(width: 100, height: 12)
                                        .foregroundColor(Color.gray)
                                    
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .frame(width: (CGFloat(healtChampion*100)/CGFloat(singleton.healtChampion)), height: 12)
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(5)
                            .background(
                                Color(red: 77/255, green: 101/255, blue: 91/255).cornerRadius(10)
                            )
                            
                            Text("\(healtChampion)/\(singleton.healtChampion)")
                                .font(.custom("PressStart2P-Regular", size: 8))
                                .foregroundColor(.black)
                        }
                    }//champion display name, yellow padding
                    .padding(5)
                    .background(
                        Color(red: 231/255, green: 233/255, blue: 205/255).cornerRadius(10)
                    )
                }//champion display name, green padding
                .padding(5)
                .background(
                    Color(red: 77/255, green: 101/255, blue: 91/255).cornerRadius(10)
                )
                
                Spacer()
                
                VStack{
                    VStack{
                        HStack{
                            Text("\(selectedEnemy.name)")
                                .font(.custom("PressStart2P-Regular", size: 9))
                                .padding(.trailing, 15)
                                .foregroundColor(.black)
                            
                            Image("Enemy")
                                .resizable()
                                .frame(width: 15, height: 15)
                            Text("\(selectedEnemy.attack)")
                                .font(.custom("PressStart2P-Regular", size: 9))
                                .foregroundColor(.black)
                        }
                        
                        HStack{
                            HStack{
                                Text("HP")
                                    .font(.custom("PressStart2P-Regular", size: 9))
                                    .foregroundColor(Color.yellow)
                                
                                ZStack(alignment: .leading){
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .frame(width: 100, height: 12)
                                        .foregroundColor(Color.gray)
                                    
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .frame(width: (CGFloat(healtEnemy*100)/CGFloat(selectedEnemy.healt)), height: 12)
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(5)
                            .background(
                                Color(red: 77/255, green: 101/255, blue: 91/255).cornerRadius(10)
                            )
                            
                            Text("\(healtEnemy)/\(selectedEnemy.healt)")
                                .font(.custom("PressStart2P-Regular", size: 8))
                                .foregroundColor(.black)
                        }
                    }//enemy display name, yellow padding
                    .padding(5)
                    .background(
                        Color(red: 231/255, green: 233/255, blue: 205/255).cornerRadius(10)
                    )
                }//enemy display name, green padding
                .padding(5)
                .background(
                    Color(red: 77/255, green: 101/255, blue: 91/255).cornerRadius(10)
                )
            }//enemy and champion display name
            
            VStack{
                //                SceneView(scene: scene, options: .autoenablesDefaultLighting)
                //                    .ignoresSafeArea()
                //
                //                Text("Enemy : \(selectedEnemy.name) - Healt : \(healtEnemy) - Champion Helat \(healtChampion)")
                //                    .font(.custom("NerkoOne-Regular", size: 18))
                
                VStack{
                    if(questionList.count > 0){
                        
                        Text("Category \(questionList[singleton.questionNumber].category ?? "NA") - Question : \(singleton.questionNumber + 1)")
                            .font(.custom("NerkoOne-Regular", size: 17))
                            .foregroundColor(.black)
                        
                        Text(questionList[singleton.questionNumber].question ?? "NA")
                            .font(.custom("NerkoOne-Regular", size: 17))
                            .foregroundColor(.black)
                        
                        if(questionList[singleton.questionNumber].incorrect_answers?.count ?? 0 == 2 || questionList[singleton.questionNumber].incorrect_answers?.count ?? 0 == 4){ //check that the correct answer was added to the array of incorrect answers
                            if(questionList[singleton.questionNumber].incorrect_answers?.count ?? 0 > 2){ // multiple answer
                                HStack(spacing: 50){
                                    VStack(alignment: .leading){
                                        Button(action:{
                                            checkAnswer(correct_answer: "\(questionList[singleton.questionNumber].correct_answer ?? "NA")" , answer_choosed: questionList[singleton.questionNumber].incorrect_answers?[0] ?? "NA")
                                        }){
                                            Text("A. \(questionList[singleton.questionNumber].incorrect_answers?[0] ?? "NA")")
                                                .font(.custom("NerkoOne-Regular", size: 17))
                                                .foregroundColor(.blue)
                                        }
                                        
                                        Button(action:{
                                            checkAnswer(correct_answer: "\(questionList[singleton.questionNumber].correct_answer ?? "NA")" , answer_choosed: questionList[singleton.questionNumber].incorrect_answers?[2] ?? "NA")
                                        }){
                                            Text("C. \(questionList[singleton.questionNumber].incorrect_answers?[2] ?? "NA")")
                                                .font(.custom("NerkoOne-Regular", size: 17))
                                                .foregroundColor(.blue)
                                        }
                                    }// VStack ends
                                    VStack(alignment: .leading){
                                        Button(action:{
                                            checkAnswer(correct_answer: "\(questionList[singleton.questionNumber].correct_answer ?? "NA")" , answer_choosed: questionList[singleton.questionNumber].incorrect_answers?[1] ?? "NA")
                                        }){
                                            Text("B. \(questionList[singleton.questionNumber].incorrect_answers?[1] ?? "NA")")
                                                .font(.custom("NerkoOne-Regular", size: 17))
                                                .foregroundColor(.blue)
                                        }
                                        
                                        Button(action:{
                                            checkAnswer(correct_answer: "\(questionList[singleton.questionNumber].correct_answer ?? "NA")" , answer_choosed: questionList[singleton.questionNumber].incorrect_answers?[3] ?? "NA")
                                        }){
                                            Text("D. \(questionList[singleton.questionNumber].incorrect_answers?[3] ?? "NA")")
                                                .font(.custom("NerkoOne-Regular", size: 17))
                                                .foregroundColor(.blue)
                                        }
                                    }// VStack ends
                                }// HStack ends
                            }//if - question is multiple or boolean
                            else{ // true or false answer
                                HStack(spacing: 50){
                                    
                                    Button(action:{
                                        checkAnswer(correct_answer: "\(questionList[singleton.questionNumber].correct_answer ?? "NA")" , answer_choosed: questionList[singleton.questionNumber].incorrect_answers?[0] ?? "NA")
                                    }){
                                        Text("A. \(questionList[singleton.questionNumber].incorrect_answers?[0] ?? "NA")")
                                            .font(.custom("NerkoOne-Regular", size: 17))
                                            .foregroundColor(.blue)
                                    }
                                    
                                    Button(action:{
                                        checkAnswer(correct_answer: "\(questionList[singleton.questionNumber].correct_answer ?? "NA")" , answer_choosed: questionList[singleton.questionNumber].incorrect_answers?[1] ?? "NA")
                                    }){
                                        Text("B. \(questionList[singleton.questionNumber].incorrect_answers?[1] ?? "NA")")
                                            .font(.custom("NerkoOne-Regular", size: 17))
                                            .foregroundColor(.blue)
                                    }
                                }// HStack ends
                            }// if - boolean question
                        }// if - conditional that the correct answer was added to the array of incorrect answers
                    }// if - conditional that check if the API request is completed
                }// VStack ends
                .allowsHitTesting(tapQuestion)
                .padding(9)
                .background(Color(red: 241/255, green: 242/255, blue: 109/255).cornerRadius(25))
                .padding(9)
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
            
            ToolbarItem(placement: .navigationBarTrailing) {
                BannerAdView(screen: "Game")
                    .frame(width: UIScreen.screenWidth/1.5)
                    .padding(.top, 25)
            }

        }
        //        .background(
        //            Color.black
        //        )
        .onAppear(){
            self.healtChampion = singleton.healtChampion
            self.healtEnemy = selectedEnemy.healt
//            self.attackEnemy = selectedEnemy.attack
            singleton.questionNumber = 0
            self.correctAnswers = 0

            //try to fetch weather fetchQuestionInfo() function
            self.questionHelper.fetchQuestionInfo( withCompletion: {question in
                print(#function, "onAppear - Question data : \(question)")
                questionList = question?.results ?? []
                print(questionList.count)


                for itr in  0..<questionList.count{
//                    questionList[itr].question = String(htmlEncodedString: questionList[itr].question ?? "NA")//modify HTML string

                    print(questionList[itr].question)

//                    questionList[itr].incorrect_answers?.append("\(questionList[itr].correct_answer ?? "NA")" ) //append answer
                    
                    questionList[itr].incorrect_answers?.shuffle()
                    for itr2 in  0..<(questionList[itr].incorrect_answers?.count ?? 0){
                        
//                        questionList[itr].incorrect_answers?[itr2] = String(htmlEncodedString: questionList[itr].incorrect_answers?[itr2] ?? "NA") ?? "NA"
                        
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
            self.correctAnswers = self.correctAnswers + 1
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
                self.healtEnemy = self.healtEnemy - singleton.attackChampion

                if(self.healtEnemy <= 0){
                    self.healtEnemy = 0
                    
                    if(self.fireDBHelper.user.db_Energy >= 10){
                        self.fireDBHelper.updateRechargeBool(rechargeBool: true)
                    }
                    
                    if(self.fireDBHelper.user.db_Level == selectedEnemy.level){//increments Level, Questions and Games
                        self.fireDBHelper.updateDataProfileGame(newLevel: self.fireDBHelper.user.db_Level + 1, newQuestions: self.fireDBHelper.user.db_Questions + singleton.questionNumber + 1, newGames: self.fireDBHelper.user.db_Games + 1, newCorrectQuestions: self.fireDBHelper.user.db_CorrectQuestions + self.correctAnswers, newEnergy: self.fireDBHelper.user.db_Energy - 1)
                    }
                    else{//increments Questions and Games no level, because the user already passes this level
                        self.fireDBHelper.updateDataProfileGame(newLevel: self.fireDBHelper.user.db_Level, newQuestions: self.fireDBHelper.user.db_Questions + singleton.questionNumber + 1, newGames: self.fireDBHelper.user.db_Games + 1, newCorrectQuestions: self.fireDBHelper.user.db_CorrectQuestions + self.correctAnswers, newEnergy: self.fireDBHelper.user.db_Energy - 1)
                    }
                    
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
                self.healtChampion = self.healtChampion - selectedEnemy.attack
                
                if(self.healtChampion <= 0){//increments Questions and Games no level, because it lose this level
                    self.healtChampion = 0
                    
                    if(self.fireDBHelper.user.db_Energy >= 10){
                        self.fireDBHelper.updateRechargeBool(rechargeBool: true)
                        print("cambiaaaaaaaa")
                    }
                    
                    self.fireDBHelper.updateDataProfileGame(newLevel: self.fireDBHelper.user.db_Level, newQuestions: self.fireDBHelper.user.db_Questions + singleton.questionNumber + 1, newGames: self.fireDBHelper.user.db_Games + 1, newCorrectQuestions: self.fireDBHelper.user.db_CorrectQuestions + self.correctAnswers, newEnergy: self.fireDBHelper.user.db_Energy - 1)
                    
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
    
    func goLevelScreen(){
        print("level \(self.fireDBHelper.user.db_Level)")
        print("question T\(self.fireDBHelper.user.db_Questions)")
        print("games \(self.fireDBHelper.user.db_Games)")
        print("correct Ques\(self.fireDBHelper.user.db_CorrectQuestions)")

        self.fireDBHelper.updateDataProfileGame(newLevel: self.fireDBHelper.user.db_Level + 1, newQuestions: 10, newGames: self.fireDBHelper.user.db_Games + 1, newCorrectQuestions: 10, newEnergy: self.fireDBHelper.user.db_Energy - 1)

        self.linkSelection = 1
        //dismiss()
    }
    
}// GameView View ends

//extension String {
//
//    init?(htmlEncodedString: String) {
//
//        guard let data = htmlEncodedString.data(using: .utf8) else {
//            return nil
//        }
//
//        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
//            .documentType: NSAttributedString.DocumentType.html,
//            .characterEncoding: String.Encoding.utf8.rawValue
//        ]
//
//        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
//            return nil
//        }
//
//        self.init(attributedString.string)
//
//    }
//
//}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}

