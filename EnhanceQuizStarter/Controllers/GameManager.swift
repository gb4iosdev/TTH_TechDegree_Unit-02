//
//  GameManager.swift
//  EnhanceQuizStarter
//
//  Created by Gavin Butler on 16-07-2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

protocol StatusDisplayDelegate: class {
    func setQuestionsAskedTo(_ val: Int)
    func setCorrectQuestionsTo(_ val: Int)
}

import Foundation
import UIKit

class GameManager {
    
    let questionsPerRound = 7
    
    weak var delegateUIViewController: StatusDisplayDelegate?
    
    var questionIndex = -1 {
        didSet { delegateUIViewController?.setQuestionsAskedTo(questionIndex + 1)}
    }
    
    var isLastRound: Bool {
        return questionIndex == questionsPerRound - 1
    }
    
    var correctQuestions = 0 {
        didSet { delegateUIViewController?.setCorrectQuestionsTo(correctQuestions) }
    }
    
    var currentQuestion: Question?
    
    func reset() {
        
        //Reset question index to start point;  re-shuffle the Trivia questions
        questionIndex = -1
        correctQuestions = 0
        Trivia.questions.shuffle()
    }
    
    func nextQuestion() -> Question {
        
        questionIndex += 1
        currentQuestion = Trivia.questions[questionIndex]
        return currentQuestion!
    }
    
    func numberOfAnswerChoices() -> Int {
        
        //This function returns the number of answers for the current question
        return currentQuestion!.answers.count
    }
    
    func correctAnswer() -> Int {
        return currentQuestion!.correctAnswer
    }
    
    func presentResult() -> String {
        
        if correctQuestions > 0 {
            return "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        } else {
            return "You didn’t get any correct answers but don’t worry, your score is still better than season 8 ratings.  Better luck next time!"
        }
    }
    
}

