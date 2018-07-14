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
    @IBOutlet weak var gifView: UIImageView!
    
    var numberOfPlayers = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepperOutlet.minimumValue = Double(numberOfPlayers)
        numberOfPlayerLabel.text = "\(numberOfPlayers)"
        gifView.loadGif(name: "LOL")
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
            }
        }
    }
}
