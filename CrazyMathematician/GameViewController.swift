//
//  GameViewController.swift
//  CrazyMathematician
//
//  Created by Alima Seytkhan on 6/29/18.
//  Copyright © 2018 ibek inc. All rights reserved.
//

import UIKit

// declaration of our protocol
protocol GameVCDelegate {
    func gameScore(score:Int)
}

class GameViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var waterView: UIView!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var statusAnswer: UILabel!
    
    var delegate:GameVCDelegate?
    var level: Int = 0
    var x = 0; var y = 0
    var gameTime = 20
    var score = 0
    var userName:String?
    var fregs = 0.3
    
    // variable for stopping time after gameOver
    var timer: Timer?
    
    // var for stopping moveQuestionLabel
    var question:Timer?
    
    // TODO
    // dictionary of user Info
    var userInfo = [Int: String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerLabel.text = "0:\(gameTime)"
        newQuestion()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.updateTimer), userInfo: nil, repeats: true)

        question = Timer.scheduledTimer(timeInterval: fregs, target: self, selector: #selector(GameViewController.moveQuestionLabel), userInfo: nil, repeats: true)
        
        
    }
    
    func newQuestion() {
        
        if level == 1 {
            self.x = Int(arc4random_uniform(9) + 1)
            self.y = Int(arc4random_uniform(9) + 1)
        } else if level == 2 {
            self.x = Int(arc4random_uniform(98) + 1)
            self.y = Int(arc4random_uniform(98) + 1)
        } else if level == 3 {
            self.x = Int(arc4random_uniform(998) + 1)
            self.y = Int(arc4random_uniform(998) + 1)
        }

        questionLabel.text = "\(x)X\(y)="
        questionLabel.center.y = 50
    }
    
    @objc func moveQuestionLabel() {
        
        if questionLabel.center.y >= waterView.center.y {
            score = score - 2
            scoreLabel.text = "Your score: \(score)"
            statusAnswer.text = "Answer quickly!"
            statusAnswer.textColor = UIColor.black
            statusAnswer.backgroundColor = UIColor.white
            newQuestion()
        }

        UIView.animate(withDuration: fregs, delay: 0, options: .curveLinear, animations: { 
            if self.level == 1 {
                self.questionLabel.center.y += 10
            } else if self.level == 2 {
                self.questionLabel.center.y += 7
            } else if self.level == 3 {
                self.questionLabel.center.y += 5
            }
        }, completion: nil)
    }
    
    @objc func updateTimer() {
        
        gameTime = gameTime - 1
        timerLabel.text = "0:\(gameTime)"
        
        
        if(gameTime == 0) {
            gameOver()
            timerLabel.text = "0"
            timer?.invalidate()
            question?.invalidate()
        }
        
    }
    
    func gameOver() {
        
        // give score to own delegate
        self.delegate?.gameScore(score: self.score)
        
        let alert = UIAlertController(title: "Game Over", message: "Your score is: \(score)", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your name"
            self.userName = textField.placeholder
        }
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            // to close controller
            // TODO
            self.dismiss(animated: true, completion: nil)
        }))
        
        // show to VC alert
        present(alert, animated: true, completion: nil)

        
    }
    
    func speedQuestionLabel() {
        
    }

    @IBAction func submitButtonPressed(_ sender: UIButton) {
    
        
        let result = Int(self.answerTextField.text!)
        
        if (result == x*y) {
            
            fregs -= 0.03
        
            question?.invalidate()
            question = nil
            question = Timer.scheduledTimer(timeInterval: fregs, target: self, selector: #selector(GameViewController.moveQuestionLabel), userInfo: nil, repeats: true)
            
            if level == 1 {
                score += 1
            } else if level == 2 {
                score += 3
            } else if level == 3 {
                score += 5
            }
            scoreLabel.text = "Your score: \(score)"
            statusAnswer.text = "Correct!"
            statusAnswer.textColor = UIColor.white
            statusAnswer.backgroundColor = UIColor.green
            newQuestion()
        } else if result != x*y {
            
            fregs += 0.04
            question?.invalidate()
            question = nil
            question = Timer.scheduledTimer(timeInterval: fregs, target: self, selector: #selector(GameViewController.moveQuestionLabel), userInfo: nil, repeats: true)
            
            score -= 2
            scoreLabel.text = "Your score: \(score)"
            statusAnswer.text = "Wrong!"
            statusAnswer.textColor = UIColor.white
            statusAnswer.backgroundColor = UIColor.red
            newQuestion()
        }

        self.answerTextField.text = ""
        
    }

}
