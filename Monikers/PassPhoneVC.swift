//
//  PassPhoneVC.swift
//  Monikers
//
//  Created by Justin Vickers on 7/21/18.
//  Copyright © 2018 Justin Vickers. All rights reserved.
//

import UIKit

class PassPhoneVC: UIViewController {

    @IBOutlet weak var passGIF: UIImageView!
//    var game = Monikers(teamOne: "", teamTwo: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passGIF.loadGif(name: "changeTeam")
    }
    @IBAction func backToPlay(_ sender: UIButton) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "BackToGameSegue" {
//            if let destinationVC = segue.destination as? ViewController {
//                destinationVC.game = game
//            }
//        }
    }
}
