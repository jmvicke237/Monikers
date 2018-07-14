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
    var teamOnePoints = 1000
    var teamTwoPoints = 0
    var winner = ""
    
    @IBOutlet weak var teamOneGIF: UIImageView!
    @IBOutlet weak var teamTwoGIF: UIImageView!
    @IBOutlet weak var teamOneScoreLabel: UILabel!
    @IBOutlet weak var teamTwoScoreLabel: UILabel!
    @IBOutlet weak var winnerGIF: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamOneGIF.loadGif(name: teamOneName + "-select")
        teamTwoGIF.loadGif(name: teamTwoName + "-select")
        teamOneScoreLabel.text = "\(teamOnePoints)"
        teamTwoScoreLabel.text = "\(teamTwoPoints)"
        winnerGIF.loadGif(name: winner + "-win")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
