//
//  DraftOrPlayVC.swift
//  Monikers
//
//  Created by Justin Vickers on 7/30/18.
//  Copyright © 2018 Justin Vickers. All rights reserved.
//

import UIKit

class DraftOrPlayVC: UIViewController {

    var namesForPlayArray = [String]()
    var teamOneName = ""
    var teamTwoName = ""
    
    @IBOutlet weak var selectCardsOutlet: UIButton!
    @IBOutlet weak var startGameOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectCardsOutlet.layer.borderWidth = 2
        selectCardsOutlet.layer.cornerRadius = 5
        selectCardsOutlet.layer.borderColor = UIColor.white.cgColor
        startGameOutlet.layer.borderWidth = 2
        startGameOutlet.layer.cornerRadius = 5
        startGameOutlet.layer.borderColor = UIColor.white.cgColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func draftButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startButton(_ sender: UIButton) {
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DraftToGameSegue" {
            if let destinationVC = segue.destination as? ViewController {
                destinationVC.namesArray = namesForPlayArray
                destinationVC.teamOneName = teamOneName
                destinationVC.teamTwoName = teamTwoName
            }
        }
        
        if segue.identifier == "DraftToRoundSegue" {
            if let destinationVC = segue.destination as? RoundInstructionsVC {
                destinationVC.namesArray = namesForPlayArray
                destinationVC.teamOneName = teamOneName
                destinationVC.teamTwoName = teamTwoName
                destinationVC.currentTeam.name = teamOneName
            }
        }
    }
    
    

}
