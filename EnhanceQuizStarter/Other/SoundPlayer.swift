//
//  SoundPlayer.swift
//  EnhanceQuizStarter
//
//  Created by Gavin Butler on 14-07-2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import AudioToolbox
import AVFoundation
import GameKit

class SoundPlayer {
    
    var backgroundSoundEffect: AVAudioPlayer?
    
    var correctAnswerSound: SystemSoundID = 0
    var inCorrectAnswerSound: SystemSoundID = 0
    
    let backgroundSoundFileNames: [String] = [
        "gotMainTheme.wav",
        "gotAlternateTheme1.wav",
        "gotAlternateTheme2.wav",       //Piano version
    ]
    
    func playRandomBackgroundSound() {
        
        let indexOfSelectedBackgroundSound = GKRandomSource.sharedRandom().nextInt(upperBound: self.backgroundSoundFileNames.count)
        let path = Bundle.main.path(forResource: backgroundSoundFileNames[indexOfSelectedBackgroundSound], ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            backgroundSoundEffect = try AVAudioPlayer(contentsOf: url)
            backgroundSoundEffect?.numberOfLoops = -1
            backgroundSoundEffect?.play()
        } catch {
            print("Could not load file: \(backgroundSoundFileNames[indexOfSelectedBackgroundSound])")
        }
    }
    
    func loadAnswerSounds() {
          loadSounds(fromFile: "right.wav", soundID: &correctAnswerSound)
          loadSounds(fromFile: "wrong.wav", soundID: &inCorrectAnswerSound)
    }
    
    func loadSounds(fromFile fileName: String, soundID: inout SystemSoundID) {
        let path = Bundle.main.path(forResource: fileName, ofType: nil)
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundID)
    }
     
     func playCorrectAnswerSound() {
        AudioServicesPlaySystemSound(correctAnswerSound)
     }
    
    func playIncorrectAnswerSound() {
        AudioServicesPlaySystemSound(inCorrectAnswerSound)
    }
    
}
