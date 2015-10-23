//
//  ViewController.swift
//  Space-calculator
//
//  Created by Андрей Букша on 23.10.15.
//  Copyright © 2015 Андрей Букша. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Equals = "="
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    
    
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()

        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(Operation.Equals)
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
            rightValStr = runningNumber
            runningNumber = ""
            
            if currentOperation == Operation.Multiply {
                result = "\(Double(leftValStr)! * Double(rightValStr)!)"
            } else if currentOperation == Operation.Divide {
                result = "\(Double(leftValStr)! / Double(rightValStr)!)"
            } else if currentOperation == Operation.Subtract {
                result = "\(Double(leftValStr)! - Double(rightValStr)!)"
            } else if currentOperation == Operation.Add {
                result = "\(Double(leftValStr)! + Double(rightValStr)!)"
            }
            
            leftValStr = result
            outputLbl.text = result
            }
            currentOperation = op
            
            
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
            
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
}