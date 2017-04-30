//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Stefano Groenland on 18/04/2017.
//  Copyright © 2017 Stefano Groenland. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""

    @IBOutlet weak var outputLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        outputLbl.text = "0"
    }
    
    
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        print("number pressed \(runningNumber)")
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject){
        processOpertation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject){
        processOpertation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject){
        processOpertation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject){
        processOpertation(operation: .Add)
    }
    
    @IBAction func onEquelPressed(sender: AnyObject){
        processOpertation(operation: currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject){
        playSound()
        runningNumber = ""
        outputLbl.text = "0"
        leftValStr = "0"
        rightValStr = "0"
        result = ""
        currentOperation = Operation.Empty
    }
    
    func playSound(){
        if btnSound.isPlaying{
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOpertation(operation: Operation){
        playSound()
        if currentOperation != Operation.Empty {
            //checks if a user selected an operator but then selected another operater without entering a number first.
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result;
            }
            currentOperation = operation;
        } else {
            //this it the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
            print("first operator")
        }
    }


}

