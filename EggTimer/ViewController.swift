//
//  ViewController.swift
//  EggTimer
//
//  Created by Amerigo Mancino on 14/10/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // dictionary of eggs cooking time in seconds
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    var audioPlayer: AVAudioPlayer!
    
    /* trigger when the user selects an egg */
    @IBAction func hardnessSelected(_ sender: UIButton) {
        // we invalidate the previous timer that was running if any
        timer.invalidate()
        
        // get the button title which metch the hardness
        let hardness = sender.currentTitle! // Hard, Medium or Soft
        
        totalTime = eggTimes[hardness]!
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        // create the timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)

    }

    // the selector function that triggers every timeInterval
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            let percentageProgress = Float(secondsPassed)/Float(totalTime)
            progressBar.progress = percentageProgress
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            playSound()
        }
    }
    
    // play an alarm when the eggs are ready
    func playSound() {
        let soundURL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        }
        catch {
            print(error)
        }
        
        audioPlayer.play()
    }

}
