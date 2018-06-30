//
//  ViewController.swift
//  LumosityColorMatch
//
//  Created by Alima Seytkhan on 6/29/18.
//  Copyright © 2018 moon inc. All rights reserved.
//

import UIKit

class LumosityColor: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    
    let colors = [
        UIColor.red,
        UIColor.black,
        UIColor.blue,
        UIColor.brown,
        UIColor.green,
        UIColor.purple
    ]
    
    let colorNames = [
        "RED",
        "BLACK",
        "BLUE",
        "BROWN",
        "GREEN",
        "PURPLE"
    ]
    
    var colorIndex = 0
    var titleIndex = 0
    var correctAnswers = 0
    var time = 0
    // timer
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupViews()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(LumosityColor.actionTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func actionTimer() {
        time += 1
        timerLabel.text = String(time)
        
        if time == 15 {
            time = 0
            timer.invalidate()
            timerLabel.text = "0"
            scoreLabel.text = "0"
            
            let alert = UIAlertController(title: "Game over", message: "Your score: \(correctAnswers)", preferredStyle: .alert)
            let againAction = UIAlertAction(title: "Start again", style: UIAlertActionStyle.default) { UIAlertAction in
                self.correctAnswers = 0
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(LumosityColor.actionTimer), userInfo: nil, repeats: true)
            }
            
            alert.addAction(againAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    func setupViews() {
        
        colorIndex = Int(arc4random_uniform(UInt32(colors.count)))
        titleIndex = Int(arc4random_uniform(UInt32(colors.count)))
        
        displayLabel.text = colorNames[titleIndex]
        displayLabel.backgroundColor = colors[colorIndex]
        
    }
    
    @IBAction func yesButtonPressed(_ sender: UIButton) {
        
        if (colorIndex == titleIndex) {
            statusLabel.text = "Right!"
            statusLabel.textColor = UIColor.white
            statusLabel.backgroundColor = UIColor.green
            correctAnswers += 1
            scoreLabel.text = "\(correctAnswers)"
        } else {
            statusLabel.text = "Wrong!"
            statusLabel.textColor = UIColor.white
            statusLabel.backgroundColor = UIColor.red
            correctAnswers -= 2
            scoreLabel.text = "\(correctAnswers)"
        }
        setupViews()
        
    }
    
    @IBAction func noButtonPressed(_ sender: UIButton) {
        
        if (colorIndex != titleIndex) {
            statusLabel.text = "Right!"
            statusLabel.textColor = UIColor.white
            statusLabel.backgroundColor = UIColor.green
            correctAnswers += 1
            scoreLabel.text = "\(correctAnswers)"
        } else {
            statusLabel.text = "Wrong!"
            statusLabel.textColor = UIColor.white
            statusLabel.backgroundColor = UIColor.red
            correctAnswers -= 2
            scoreLabel.text = "\(correctAnswers)"
        }
        setupViews()
        
    }
    
}


