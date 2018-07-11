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
    
    @IBOutlet weak var teamOneNameLabel: UILabel!
    @IBOutlet weak var teamTwoNameLabel: UILabel!
    @IBOutlet weak var teamOneScoreLabel: UILabel!
    @IBOutlet weak var teamTwoScoreLabel: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamOneNameLabel.text = teamOneName
        teamTwoNameLabel.text = teamTwoName
        teamOneScoreLabel.text = "\(teamOnePoints)"
        teamTwoScoreLabel.text = "\(teamTwoPoints)"
        winnerLabel.text = winner
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
