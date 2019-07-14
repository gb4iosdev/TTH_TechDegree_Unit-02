//
//  SoundPlayer.swift
//  EnhanceQuizStarter
//
//  Created by Gavin Butler on 14-07-2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

//import Foundation
import AudioToolbox
import AVFoundation
import GameKit

class SoundPlayer {
    
    var backgroundSoundEffect: AVAudioPlayer?
    
    let backgroundSoundFileNames: [String] = [
        "gotMainTheme.wav",
        "gotAlternateTheme1.wav",
        "gotAlternateTheme2.wav",       //Piano version
    ]
    
    /*func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        //AudioServicesPlaySystemSound(gameSound)
    }*/
    
    func playRandomBackgroundSound() {
        
        let indexOfSelectedBackgroundSound = GKRandomSource.sharedRandom().nextInt(upperBound: self.backgroundSoundFileNames.count)
        //print("index is: \(indexOfSelectedBackgroundSound) and name is: \(backgroundSoundFileNames[indexOfSelectedBackgroundSound])")
        let path = Bundle.main.path(forResource: backgroundSoundFileNames[indexOfSelectedBackgroundSound], ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            backgroundSoundEffect = try AVAudioPlayer(contentsOf: url)
            backgroundSoundEffect?.numberOfLoops = -1
            backgroundSoundEffect?.play()
            //backgroundSoundEffect?.setVolume(_ volume: fadeDuration duration: TimeInterval)
        } catch {
            // couldn't load file :(
        }
    }
    
}
