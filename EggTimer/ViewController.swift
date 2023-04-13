//
//  ViewController.swift
//  EggTimer
//
//  Created by Иван Станкин on 13.04.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var stopButtonUI: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTime = ["Soft": 3, "Medium": 420, "Hard": 720]
    
    var timer: Timer?
    
    var totalTime = 0
    
    var secondsPassed = 0
    
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButtonUI.isHidden = true
        
        progressBar.progress = 0
        
    }
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        stopButtonUI.isHidden = false
        
        timer?.invalidate()
        
        let hardness = sender.currentTitle!
        
        totalTime = eggTime[hardness]!
        
        progressBar.progress = 0.0
        
        secondsPassed = 0
        
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
        
    }
    
    @objc func timerUpdate() {
        
        if secondsPassed < totalTime {
            
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            
        } else {
            timer?.invalidate()
            print("Does it stop?")
            titleLabel.text = "Done!"
            alarmSound()
            stopButtonUI.isHidden = true
        }
    }
    
    func alarmSound(){
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        
        timer?.invalidate()
        print("Timer stopped")
        titleLabel.text = "How do you like your eggs?"
        stopButtonUI.isHidden = true
        progressBar.progress = 0.0
        
    }
    
}

