//
//  ViewController.swift
//  CrazyMathematician
//
//  Created by Alima Seytkhan on 6/29/18.
//  Copyright © 2018 ibek inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var firstLVLbutton: UIButton!
    @IBOutlet weak var secondLVLbutton: UIButton!
    @IBOutlet weak var thirdLVLbutton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    var bestScore = 0
    var didSelected = false


    override func viewDidLoad() {
        super.viewDidLoad()

        //for saving primitive data types
        bestScore = UserDefaults.standard.integer(forKey: "best")
        self.bestScoreLabel.text = "\(bestScore)"
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        
        if didSelected {
            startButton.isEnabled = false
            if firstLVLbutton.isSelected == true || secondLVLbutton.isSelected == true || (thirdLVLbutton.isSelected == true) {
                startButton.isEnabled = true
                performSegue(withIdentifier: "toGameVC", sender: nil)
            } else {
                startButton.isEnabled = false
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // проверка seque тот или нет
        if (segue.destination.isKind(of: GameViewController.self)) {
            let gameVC = segue.destination as! GameViewController
            // we write the code to call method GAMESCORE else it will be nil
            //TODO
            if firstLVLbutton.isSelected {
                gameVC.level = 1
            }
            else if secondLVLbutton.isSelected {
                gameVC.level = 2
            } else if thirdLVLbutton.isSelected {
                gameVC.level = 3
            }
            gameVC.delegate = self
        }

    }
    
    // level buttons
    @IBAction func firstLevelButtonPressed(_ sender: UIButton) {
        
        didSelected = true
        
        firstLVLbutton.isSelected = true
        secondLVLbutton.isSelected = false
        thirdLVLbutton.isSelected = false
    }
    
    @IBAction func secondLevelButtonPressed(_ sender: UIButton) {
        
        didSelected = true
        
        firstLVLbutton.isSelected = false
        secondLVLbutton.isSelected = true
        thirdLVLbutton.isSelected = false
    }
    
    @IBAction func thirdLevelButtonPressed(_ sender: UIButton) {
        
        didSelected = true
        
        firstLVLbutton.isSelected = false
        secondLVLbutton.isSelected = false
        thirdLVLbutton.isSelected = true
    }
    
    @IBAction func allScoresBTNpressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Updating", message: "In next version will be the all best scores of the users", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    @IBAction func unwind(segue: UIStoryboardSegue) {
    }
}

extension ViewController: GameVCDelegate {
    func gameScore(score: Int) {
        
        if (score > bestScore) {
            bestScore = score
            UserDefaults.standard.set(bestScore, forKey: "best")
        }
        
        self.bestScoreLabel.text = "\(bestScore)"
    }
}

