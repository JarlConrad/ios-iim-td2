//
//  ViewController.swift
//  Bull's Eyes UIKit
//
//  Created by Adrien DELIEGE on 26/02/2020.
//  Copyright © 2020 Adrien DELIEGE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentValue: Int = 0
    var targetValue: Int = 0
    var totalScore: Int = 0
    var totalRound: Int = 0
    @IBOutlet weak var valueToTarget: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var round: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftImageResizeable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftImageResizeable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightImageResizeable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightImageResizeable, for: .normal)
        
        startNewRound()
        // Do any additional setup after loading the view.
    }
    
    func startNewRound() {
        totalRound += 1
        round.text = String(totalRound)
        score.text = String(totalScore)
        targetValue = Int.random(in: 1...100)
        valueToTarget.text = String(targetValue)
        slider.value = 50
        currentValue = Int(slider.value)
    }

    @IBAction func showAlert() {
        var currentRoundScore: Int = 100 - abs(targetValue - currentValue)
        
        var sentenceToShow: String = ""
        
        switch (currentRoundScore) {
        case 1...75:
            sentenceToShow = "Pas térrible"
        case 76...98:
            sentenceToShow = "Pas mal"
        case 99:
            sentenceToShow = "Presque parfait !"
            currentRoundScore += 50
        case 100:
            sentenceToShow = "Parfait !"
            currentRoundScore += 100
        default:
            sentenceToShow = "Je sais pas :("
        }
        
        sentenceToShow = sentenceToShow + " ("+String(currentRoundScore)+") "
        
        totalScore = totalScore + currentRoundScore
        
        let alert = UIAlertController(title: sentenceToShow, message: "La valeur séléctionnée : "+String(currentValue), preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func resetGame() {
        currentValue = 0
        targetValue = 0
        totalScore = 0
        totalRound = 0
        startNewRound()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = Int(slider.value)
    }
}

