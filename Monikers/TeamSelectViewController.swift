//
//  TeamSelectViewController.swift
//  Monikers
//
//  Created by Justin Vickers on 7/9/18.
//  Copyright © 2018 Justin Vickers. All rights reserved.
//

import UIKit

class TeamSelectViewController: UIViewController {

    @IBOutlet weak var numberOfPlayerLabel: UILabel!
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var teamOneGif: UIImageView!
    @IBOutlet weak var teamTwoGif: UIImageView!
    
    var numberOfPlayers = 4
    var teamList = ["fish", "doll", "blacula", "brain", "cat", "schrodinger", "twins"]
    var teamOneName = ""
    var teamTwoName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamOneName = teamList.remove(at: teamList.count.arc4random)
        teamTwoName = teamList.remove(at: teamList.count.arc4random)
        stepperOutlet.minimumValue = Double(numberOfPlayers)
        numberOfPlayerLabel.text = "\(numberOfPlayers)"
        teamOneGif.loadGif(name: teamOneName + "-select")
        teamTwoGif.loadGif(name: teamTwoName + "-select")
    }

    @IBAction func numberOfPlayersStepper(_ sender: UIStepper) {
        numberOfPlayers = Int(sender.value)
        numberOfPlayerLabel.text = "\(numberOfPlayers)"
    }
    
    @IBAction func playButton(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToGame" {
            if let destinationVC = segue.destination as? ViewController {
                destinationVC.numberOfPlayers = numberOfPlayers
                destinationVC.teamOneName = teamOneName
                destinationVC.teamTwoName = teamTwoName
            }
        }
    }
}
