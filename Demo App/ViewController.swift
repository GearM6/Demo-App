//
//  ViewController.swift
//  Demo App
//
//  Created by Matthew Marra on 7/21/16.
//  Copyright © 2016 Matthew Marra. All rights reserved.
//
import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var winLabel: UILabel!
    let smallItemSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("WW_Fanfare_SmallItem", ofType: "wav")!)
    let grandPrizeSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("WW_Fanfare_HeartContainer", ofType: "wav")!)
    var soundMachine = AVAudioPlayer()
    
    //Probability
    @IBOutlet weak var resertButton: UIButton!
    let probability = 100
    var grandPrizeWon = false
    var reset = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        winLabel.hidden = true
        resertButton.hidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resetPanel(sender: AnyObject) {
        winLabel.hidden = true
        reset = true
        resertButton.hidden = true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if reset { //If the screen hasn't been cleared, run the following code
            let random = arc4random_uniform((UInt32(probability))) // Generate a random number between 0 and the variable "probability"
            print(random) //Print that number to the console
            
            winLabel.hidden = false //Show the Win Label
            switch random {
            case 0: //If the random number is 0, run the following code
                if grandPrizeWon { //Check to see if the grand prize has already been won //If it has, display the winning screen for a regular win
                    winLabel.text = "You won a prize!" //Display the red text on the screen
                    resertButton.hidden = false //Un-Hide the reset button
                    winLabel.textColor = UIColor(red: 0, green: 204, blue: 0, alpha: 1) //Set the color of the Win Label
                    do {
                        soundMachine = try AVAudioPlayer(contentsOfURL: smallItemSound)
                        soundMachine.prepareToPlay()
                        soundMachine.play()
                    } catch {print("Error, file not found")} //If the file cannot be found, display an error
                    break
                    
                }
                else { //If the grand prize hasn't been won, run this code
                    do {
                        soundMachine = try AVAudioPlayer(contentsOfURL: grandPrizeSound)
                        soundMachine.prepareToPlay()
                        soundMachine.play()
                    } catch {print("Error, file not found")}
                    
                    winLabel.text = "You won the grand prize!" //Display the red text to the user
                    resertButton.hidden = false //Unhide the reset button
                    winLabel.textColor = UIColor(red: 0, green: 102, blue: 255, alpha: 1) //Set the color of the Win Label
                }
            
            case 1, 2, 3, 4, 5, 6, 7, 8, 9, 10: //If the random number is any of these numbers, run this code block
                winLabel.text = "You won a prize!" // Display this red text
                resertButton.hidden = false //Unhide the reset button
                winLabel.textColor = UIColor(red: 0, green: 204, blue: 0, alpha: 1) //Set the color of the Win Label
                do {
                    soundMachine = try AVAudioPlayer(contentsOfURL: smallItemSound)
                    soundMachine.prepareToPlay()
                    soundMachine.play()
                } catch {print("Error, file not found")} //If it can't find the file, print this to the console
                
            default: //In literally EVERY OTHER CASE, run this code
                winLabel.text = "HAHAHA YOU LOSE PUNK!" //Display this red text
                resertButton.hidden = false //Unhide the reset button
                winLabel.textColor = UIColor(red: 128, green: 0, blue: 0, alpha: 1) //Set the color of the Win Label
            }
            reset = false //Tell the computer that the situation needs to be reset to be run again.
        }
        }
}

