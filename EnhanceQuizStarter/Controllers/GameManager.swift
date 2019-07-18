//
//  GameManager.swift
//  EnhanceQuizStarter
//
//  Created by Gavin Butler on 16-07-2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation
import UIKit

class GameManager {
    
    let questionsPerRound = 7
    
    private var questionIndex = -1
    
    var questionsAsked: String {
        return String(questionIndex + 1)
    }
    
    var isLastRound: Bool {
        return questionIndex == questionsPerRound - 1
    }
    
    var correctAnswers = 0
    
    var currentQuestion: Question?
    
    func reset() {
        
        //Reset question index to start point;  re-shuffle the Trivia questions
        questionIndex = -1
        correctAnswers = 0
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
        //Returns the correct answer for the current question
        return currentQuestion!.correctAnswer
    }
    
    func isCorrectAnswer(_ userAnswer: Int) -> Bool {
        //Returns true if user answer is correct and updates correctAnswers
        if userAnswer == correctAnswer() {
            correctAnswers += 1
            return true
        } else {
            return false
        }
    }
    
    func presentResult() -> String {
        
        if correctAnswers > 0 {
            return "Way to go!\nYou got \(correctAnswers) out of \(questionsPerRound) correct!"
        } else {
            return "You didn’t get any correct answers but don’t worry, your score is still better than season 8 ratings.  Better luck next time!"
        }
    }
    
}

