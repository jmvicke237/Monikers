//
//  InstructionsVC.swift
//  Monikers
//
//  Created by Justin Vickers on 7/27/18.
//  Copyright © 2018 Justin Vickers. All rights reserved.
//

import UIKit

class InstructionsVC: UIViewController {

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var select: UIButton!
    var teamOneName = ""
    var teamTwoName = ""
    var numberOfPlayers = 0
    @IBOutlet weak var instructionsText: UILabel!
    @IBAction func selectCardsButton(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        select.layer.borderWidth = 2
        select.layer.cornerRadius = 5
        select.layer.borderColor = UIColor.white.cgColor
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
