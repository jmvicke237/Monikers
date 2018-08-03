//
//  RoundInstructionsVC.swift
//  Monikers
//
//  Created by Justin Vickers on 8/2/18.
//  Copyright © 2018 Justin Vickers. All rights reserved.
//

import UIKit

class RoundInstructionsVC: UIViewController {

    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var rulesLabel: UILabel!
    @IBAction func startButton(_ sender: UIButton) {
        if currentRound != .roundOne {
            dismiss(animated: true, completion: nil)
        } else {
            self.performSegue(withIdentifier: "InstructionsToGameSegue", sender:self)
        }
    }
    
    var currentTeam = Team("Team one")
    var currentRound: Round = .roundOne
    var instructions = ""
    var teamOneName = ""
    var teamTwoName = ""
    var namesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch currentRound {
        case .roundOne:
            instructions = "Get your team to guess as many names as they can in 60 seconds using words, sounds, & charades. Just don't say the name itself."
            break
        case .roundTwo:
            instructions = "Same rules as Round 1, except now you can only say one word. Repeat it as much as you like, but you can't use sounds or gestures."
            break
        case .roundThree:
            instructions = "Same rules but you can only do charades. No words. Sound effects are OK (within reason). Also: put the phone on a flat surface first?"
            break
        default:
            instructions = "How did you discover the secret 4th round?"
            break
        }
        if currentRound == .roundOne {
            switch currentTeam.name {
            case "fish", "doll", "blacula":
                teamNameLabel.text = "Team one"
                break
            default:
                teamNameLabel.text = "Team two"
                break
            }
            roundLabel.text = currentRound.rawValue
            rulesLabel.text = instructions
            teamImage.loadGif(name: currentTeam.name + "-play")
            print(currentTeam.name)
        } else {
            roundLabel.text = currentRound.rawValue
            rulesLabel.text = instructions
            switch currentTeam.name {
            case "fish", "doll", "blacula":
                teamNameLabel.text = "Team one"
                teamImage.loadGif(name: teamOneName + "-play")
                break
            default:
                teamNameLabel.text = "Team two"
                teamImage.loadGif(name: teamTwoName + "-play")
                break
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InstructionsToGameSegue" {
            if let destinationVC = segue.destination as? ViewController {
                print("Segueing")
                destinationVC.namesArray = namesArray
                destinationVC.teamOneName = teamOneName
                destinationVC.teamTwoName = teamTwoName
            }
        }
    }
    
    
}
