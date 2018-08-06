//
//  EndGameVC.swift
//  Monikers
//
//  Created by Justin Vickers on 7/10/18.
//  Copyright © 2018 Justin Vickers. All rights reserved.
//

import UIKit

class EndGameVC: UIViewController {

    var teamOneName = ""
    var teamTwoName = ""
    var teamOnePoints = 0
    var teamTwoPoints = 0
    var winner = ""
    
    @IBOutlet weak var playAgainOutlet: UIButton!
    @IBOutlet weak var teamOneGIF: UIImageView!
    @IBOutlet weak var teamTwoGIF: UIImageView!
    @IBOutlet weak var teamOneScoreLabel: UILabel!
    @IBOutlet weak var teamTwoScoreLabel: UILabel!
    @IBOutlet weak var winnerGIF: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamOneGIF.loadGif(name: teamOneName + "-select")
        teamTwoGIF.loadGif(name: teamTwoName + "-select")
        teamOneScoreLabel.text = "\(teamOnePoints) points"
        teamTwoScoreLabel.text = "\(teamTwoPoints) points"
        winnerGIF.loadGif(name: winner + "-win")
        playAgainOutlet.layer.borderWidth = 2
        playAgainOutlet.layer.cornerRadius = 5
        playAgainOutlet.layer.borderColor = UIColor.white.cgColor
    }
}
