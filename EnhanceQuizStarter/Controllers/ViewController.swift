//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//
//  Attributions:
//  Quiz Questions: https://www.theguardian.com/tv-and-radio/quiz/2015/apr/11/game-of-thrones-quiz
//  Theme sounds:   https://www.youtube.com/watch?v=Hf9u3jPvkkI
//                  https://www.youtube.com/watch?v=-d7J_QVX2U4
//                  https://www.youtube.com/watch?v=yZGBxiNPu3k

import UIKit
import GameKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let questionsPerRound = 7
    let roundDelay = 3    //delay between questions
    var indexOfSelectedQuestion = 0
    var timerMax = 15
    var questionsAsked = 1 {
        didSet { questionsAskedLabel.text = String(questionsAsked) }
    }
    var correctQuestions = 0 {
        didSet { correctAnswersLabel.text = String(correctQuestions) }
    }
    var timerCount = 15 {
        didSet { timerOutputLabel.text = String(timerCount) }
    }
    
    var buttons: [UIButton] = []        // Convenience collection
    var resultImageViews: [UIImageView] = []    // Convenience collection
    
    var trivia = Trivia()   // Class containing questions
    
    var timer = Timer()
    
    let soundPlayer = SoundPlayer()
    
    // For emphasiszing questionField font when providing results feedback to user
    let questionFieldLargeFontSize: CGFloat = 30.0
    let questionFieldStandardFontSize:CGFloat = 20.0
    
    // Duration for alpha transitions - answer buttons, play again button, results icons fading in/out etc
    var animationDuration = 0.5
    
    // MARK: - Outlets
    
    @IBOutlet weak var questionField: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var resultImageView1: UIImageView!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var resultImageView2: UIImageView!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var resultImageView3: UIImageView!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var resultImageView4: UIImageView!
    
    @IBOutlet weak var playAgainButton: UIButton!

    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var timerOutputLabel: UILabel!
    @IBOutlet weak var correctAnswersLabel: UILabel!
    @IBOutlet weak var questionsPerRoundLabel: UILabel!
    @IBOutlet weak var questionsAskedLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load answer result feedback sounds
        soundPlayer.loadAnswerSounds()
        
        //Choose randome theme sound for repeated loop
        soundPlayer.playRandomBackgroundSound()
        
        //Create button and result icon convenience collections
        buttons = [button1, button2, button3, button4]
        resultImageViews = [resultImageView1, resultImageView2, resultImageView3, resultImageView4]
        
        questionsPerRoundLabel.text = String(questionsPerRound)
        
        displayQuestion()
        
        startTimer()
    }
    
    func displayQuestion() {
        
        //Select and display question:
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.questions.count)
        let thisQuestionObject = trivia.questions[indexOfSelectedQuestion]
        questionField.text = thisQuestionObject.question
        
        //Display associated Image
        backGroundImageView.image = UIImage(named: thisQuestionObject.imageName)
        
        //Display the answer choices on the buttons & enable
        for (index, answerChoice) in thisQuestionObject.answers.enumerated() {
            buttons[index].alpha = 0
            buttons[index].isHidden = false
            buttons[index].isUserInteractionEnabled = true
            buttons[index].setTitle(answerChoice, for: .normal)
        }
        
        animateButtonsAppearance()
        
        //  Hide any buttons that don’t have an answer choice (if number of choices < number of buttons)
        if buttons.count > thisQuestionObject.answers.count {
            for index in thisQuestionObject.answers.count..<buttons.count {
                buttons[index].isHidden = true
            }
        }
        
        //Ensure playAgainButton is faded to not visible
        animateAlpha(forView: playAgainButton, toAlpha: 0.0)
    }
    
    func loadNextRound(delay seconds: Int) {
        //fade out the buttons
        self.animateButtonsAppearance(withFadeOut: true)
        
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Remove the question from the trivia questions array and continue game
            trivia.questions.remove(at: indexOfSelectedQuestion)
            
            //Prepare UI for next round:
            removeButtonBorders()
            resetButtonAlphas()
            questionField.font = questionField.font.withSize(questionFieldStandardFontSize) //Restore font in question field
            
            // Increment the questions asked counter
            questionsAsked += 1
            
            displayQuestion()
            
            // Rest the timer
            timerCount = timerMax
            startTimer()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        //Stop the timer
        timer.invalidate()
        
        //Add a border to the button selected
        sender.layer.borderWidth = 2
        sender.layer.borderColor = UIColor.white.cgColor
        
        disableButtons()
        
        var userAnswer = 0
        
        //Determine the correct answer
        let selectedQuestionDict = trivia.questions[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.correctAnswer
        
        switch sender {
            case button1:    userAnswer = 0
            case button2:    userAnswer = 1
            case button3:    userAnswer = 2
            case button4:    userAnswer = 3
            default: break
        }
        
        //Emphasize font in question field
        questionField.font = questionField.font.withSize(questionFieldLargeFontSize)
        
        if userAnswer == correctAnswer {
            correctQuestions += 1
            questionField.text = "Correct!"
            soundPlayer.playCorrectAnswerSound()
        } else {
            questionField.text = "Sorry, wrong answer!"
            soundPlayer.playIncorrectAnswerSound()
            //Indicate incorrect button
            resultImageViews[userAnswer].alpha = 0.7
            resultImageViews[userAnswer].isHidden = false
            resultImageViews[userAnswer].image = UIImage(named: "wrong_white")
        }
        
        //Indicate correct button
        resultImageViews[correctAnswer].alpha = 0.7
        resultImageViews[correctAnswer].isHidden = false
        resultImageViews[correctAnswer].image = UIImage(named: "correct_white")
        
        //Fade non-chosen buttons
        for index in 0..<buttons.count {
            if index != userAnswer && index != correctAnswer {
                animateAlpha(forView: buttons[index], toAlpha: 0.6)
            }
        }
        
        loadNextRound(delay: roundDelay)
    }
    
    func displayScore() {
        // Hide the answer buttons
        animateButtonsAppearance(withFadeOut: true)
        
        // Display play again button
        playAgainButton.alpha = 0
        playAgainButton.isHidden = false
        playAgainButton.isUserInteractionEnabled = true
        animateAlpha(forView: playAgainButton, toAlpha: 1.0)
        
        if correctQuestions > 0 {
            questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        } else {
            questionField.text = "You didn’t get any correct answers but don’t worry, your score is still better than season 8 ratings.  Better luck next time!"
        }
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        //Disable the ability to press again before fadeout & fade
        sender.isUserInteractionEnabled = false
        animateAlpha(forView: sender, toAlpha: 0.0)
        
        questionsAsked = 0
        correctQuestions = 0
        //reset the trivia
        trivia = Trivia()
        nextRound()
    }
}

extension ViewController {
    
    // MARK: - Timer
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            //update timer output label
            self.timerCount -= 1    //use didset on variable to update display?
            
            if self.timerCount == 0 {
                //Freeze the buttons:
                for button in self.buttons {
                    button.isHidden = true
                }
                //Stop the timer, update & display game statistics, load next round:
                timer.invalidate()
                
                //Display message:
                //Emphasize font in question field
                self.questionField.font = self.questionField.font.withSize(self.questionFieldLargeFontSize)
                self.questionField.text = "Timed Out!"
                self.loadNextRound(delay: self.roundDelay)
            }
        }
    }
    
    // MARK: - Animators
    
    func animateButtonsAppearance(withFadeOut fadeOut: Bool = false) {
        var destinationAlpha: CGFloat
        var delayTimeInterval: Double
        destinationAlpha = fadeOut ? 0.0 : 1.0
        
        for (index, button) in buttons.enumerated() {
            if fadeOut {
                delayTimeInterval = 1.0 + 0.15 * Double(buttons.count - index - 1)
                animateAlpha(forView: resultImageViews[index], toAlpha: destinationAlpha, withDelay: delayTimeInterval)
            } else {
                delayTimeInterval = 1.0 + 0.15 * Double(index)
            }
            animateAlpha(forView: button, toAlpha: destinationAlpha, withDelay: delayTimeInterval)
            
        }
    }
    
    func animateAlpha(forView animatedView: UIView, toAlpha alpha: CGFloat, withDelay delayTimeInterval: Double = 0) {
        
        UIView.animate(withDuration: animationDuration,
                       delay: delayTimeInterval,
                       options: [UIViewAnimationOptions.curveLinear],
                       animations: {
                        animatedView.alpha = alpha
        },
                       completion: nil
        )
    }
    
    func removeButtonBorders() {
        for button in buttons {
            button.layer.borderWidth = 0
            button.layer.borderColor = nil
        }
    }
    
    func disableButtons() {
        for button in buttons {
            button.isUserInteractionEnabled = false
        }
    }
    
    func resetButtonAlphas() {
        for button in buttons {
            button.alpha = 1.0
        }
    }
}

