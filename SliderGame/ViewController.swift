//
//  ViewController.swift
//  SliderGame
//
//  Created by ertuğrul gazi akça on 11.01.2018.
//  Copyright © 2018 iosDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    var difference: Int = 0
    var score: Int = 0
    var totalScore: Int = 0
    var roundCount: Int = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        updateLabels()
        
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal") //UIImage(named: "SliderThumb-Normal")!
        
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted") //UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft") //UIImage(named: "SliderTrackLeft")! 
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")//UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
    }
    
    func startNewRound(){
        targetValue = 1 + Int(arc4random_uniform(100))
        if targetValue == 100 {
            targetValue = 1 + Int(arc4random_uniform(100))
        }
        currentValue = 50
        slider.value = Float(currentValue)
        roundCount += 1
        roundLabel.text = "\(roundCount)"
    }
    
    
    func calculateScore(){
        if targetValue > currentValue {
            difference = targetValue - currentValue
        }else if currentValue > targetValue {
            difference = currentValue - targetValue
        }else{
            difference = 0
        }
        
        score = 100 - difference
        
        if score == 100 {
            score = 150 
        }else if score < 50 {
            score = score - 10
        }
        
    }
    
    
    @IBAction func startOverButton(_ sender: UIButton) {
        totalScore = 0
        roundCount = 0
        scoreLabel.text = "0"
        roundLabel.text = "0"
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
        
    }
    
    @IBAction func showAlert(){
        calculateScore()
        totalScore += score
        scoreLabel.text = "\(totalScore)"
        
        let title: String
        
        if difference == 0 {
            title = "perfect" 
        }else if difference < 5 {
            title = "good"
        }else if difference < 10 {
            title = "eh işte good"
        }else {
            title = "not even close ha ha ha"
        }
        
        let message = "Your score: \(score) points"
        
        let alert = UIAlertController(title: "\(title)",
                                      message: "\(message)",
            preferredStyle: .alert)
        let action = UIAlertAction(title:"OK",
                                   style: .default,
                                   handler: { action in
                                            self.startNewRound()
                                            self.updateLabels()
                                            })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        //print("The value that you choosed now: \(slider.value)" )
        currentValue = lroundf(slider.value)
    }
}

