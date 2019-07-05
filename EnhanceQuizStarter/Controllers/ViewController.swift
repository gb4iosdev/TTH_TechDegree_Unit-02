//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion = 0
    var buttons: [UIButton] = []
    
    var gameSound: SystemSoundID = 0
    
    var trivia = Trivia()
    
    // MARK: - Outlets
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!

    @IBOutlet weak var backGroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGameStartSound()
        playGameStartSound()
        buttons = [button1, button2, button3, button4]
        
        displayQuestion()
    }
    
    // MARK: - Helpers
    
    func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        //AudioServicesPlaySystemSound(gameSound)
    }
    
    func displayQuestion() {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.questions.count)
        let thisQuestionObject = trivia.questions[indexOfSelectedQuestion]
        questionField.text = thisQuestionObject.question
        backGroundImageView.image = UIImage(named: thisQuestionObject.imageName)
        //Display the answer choices on the buttons
        for (index, answerChoice) in thisQuestionObject.answers.enumerated() {
            buttons[index].isHidden = false
            buttons[index].setTitle(answerChoice, for: .normal)
        }
        
        //  Grey out any buttons that don’t have an answer choice (if number of choices < number of buttons)
        if buttons.count > thisQuestionObject.answers.count {
            for index in thisQuestionObject.answers.count..<buttons.count {
                buttons[index].isHidden = true
            }
        }
        
        playAgainButton.isHidden = true
    }
    
    func displayScore() {
        // Hide the answer buttons
        for button in buttons {
            button.isHidden = true
        }
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Remove the question from the trivia questions array and continue game
            trivia.questions.remove(at: indexOfSelectedQuestion)
            displayQuestion()
        }
    }
    
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        var userAnswer = 0
        
        let selectedQuestionDict = trivia.questions[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.correctAnswer
        
        switch sender {
            case button1:    userAnswer = 0
            case button2:    userAnswer = 1
            case button3:    userAnswer = 2
            case button4:    userAnswer = 3
            default: break
        }
        
        if userAnswer == correctAnswer {
            correctQuestions += 1
            questionField.text = "Correct!"
        } else {
            questionField.text = "Sorry, wrong answer!"
        }
        
        loadNextRound(delay: 2)
    }
    
    
    @IBAction func playAgain(_ sender: UIButton) {
        // Show the answer buttons
        for button in buttons {
            button.isHidden = false
        }
        
        questionsAsked = 0
        correctQuestions = 0
        //reset the trivia
        trivia = Trivia()
        nextRound()
    }
    

}

