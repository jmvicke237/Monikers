//
//  EndOfRoundVC.swift
//  Monikers
//
//  Created by Justin Vickers on 8/3/18.
//  Copyright © 2018 Justin Vickers. All rights reserved.
//

import UIKit

class EndOfRoundVC: UIViewController {

    @IBOutlet weak var teamOneImage: UIImageView!
    @IBOutlet weak var teamTwoImage: UIImageView!
    @IBOutlet weak var teamOneLabel: UILabel!
    @IBOutlet weak var teamTwoLabel: UILabel!
    
    
    
    
    
    var currentTeam = Team("Team one")
    var currentRound: Round = .roundOne
    var teamOneName = "fish"
    var teamTwoName = ""
    var teamOnePoints = 0
    var teamTwoPoints = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        teamOneImage.loadGif(name: teamOneName + "-select")
        teamTwoImage.loadGif(name: teamTwoName + "-select")
        teamOneLabel.text = "\(teamOnePoints) points"
        teamTwoLabel.text = "\(teamTwoPoints) points"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "NextRoundSegue" {
            if let destinationVC = segue.destination as? RoundInstructionsVC {
                destinationVC.teamOneName = teamOneName
                destinationVC.teamTwoName = teamTwoName
                destinationVC.currentRound = currentRound
                destinationVC.currentTeam = currentTeam
            }
        }
    }

}
