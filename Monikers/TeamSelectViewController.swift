//
//  TeamSelectViewController.swift
//  Monikers
//
//  Created by Justin Vickers on 7/9/18.
//  Copyright © 2018 Justin Vickers. All rights reserved.
//

import UIKit

class TeamSelectViewController: UIViewController {

    @IBOutlet weak var teamOneGif: UIImageView!
    @IBOutlet weak var teamTwoGif: UIImageView!
    @IBOutlet weak var play: UIButton!
    
    var numberOfPlayers = 4
    var teamList = ["fish", "doll", "blacula", "brain", "cat", "schrodinger", "twins"]
    var teamOneList = [String]()
    var teamTwoList = [String]()
    var teamOneName = ""
    var teamTwoName = ""
    var teamOneNameIndex = 0
    var teamTwoNameIndex = 0
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0..<teamList.count / 2 {
            teamOneList.append(teamList.remove(at: 0))
        }
        for _ in 0..<teamList.count - 1 {
            teamTwoList.append(teamList.remove(at: 0))
        }
        teamOneName = teamOneList[0]
        teamTwoName = teamTwoList[0]
        teamOneGif.loadGif(name: teamOneName + "-select")
        teamTwoGif.loadGif(name: teamTwoName + "-select")
        play.layer.borderWidth = 2
        play.layer.cornerRadius = 5
        play.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func playButton(_ sender: UIButton) {
    }
    
    @IBAction func teamOneButton(_ sender: UIButton) {
        teamOneNameIndex += 1
        teamOneNameIndex = teamOneNameIndex % (teamOneList.count)
        teamOneName = teamOneList[teamOneNameIndex]
        teamOneGif.loadGif(name: teamOneName + "-select")
    }
    
    @IBAction func teamTwoButton(_ sender: UIButton) {
        teamTwoNameIndex += 1
        teamTwoNameIndex = teamTwoNameIndex % (teamTwoList.count)
        teamTwoName = teamTwoList[teamTwoNameIndex]
        teamTwoGif.loadGif(name: teamTwoName + "-select")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlayGameSegue" {
            if let destinationVC = segue.destination as? ViewController {
                destinationVC.teamOneName = teamOneName
                destinationVC.teamTwoName = teamTwoName
            }
        }
        if segue.identifier == "DraftInstructionsSegue" {
            if let destinationVC = segue.destination as? InstructionsVC {
                destinationVC.teamOneName = teamOneName
                destinationVC.teamTwoName = teamTwoName
            }
        }
    }
}
