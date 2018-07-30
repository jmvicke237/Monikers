//
//  InstructionsVC.swift
//  Monikers
//
//  Created by Justin Vickers on 7/27/18.
//  Copyright © 2018 Justin Vickers. All rights reserved.
//

import UIKit

class InstructionsVC: UIViewController {

    var teamOneName = ""
    var teamTwoName = ""
    var numberOfPlayers = 0
    @IBOutlet weak var instructionsText: UILabel!
    @IBAction func selectCardsButton(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DraftingSegue" {
            if let destinationVC = segue.destination as? DraftingVC {
                destinationVC.teamOneName = teamOneName
                destinationVC.teamTwoName = teamTwoName
            }
        }
    }

}
