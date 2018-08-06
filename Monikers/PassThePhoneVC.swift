//
//  PassThePhoneVC.swift
//  Monikers
//
//  Created by Justin Vickers on 8/2/18.
//  Copyright © 2018 Justin Vickers. All rights reserved.
//

import UIKit

class PassThePhoneVC: UIViewController {

    @IBOutlet weak var gifImage: UIImageView!
    @IBAction func startButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var startButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gifImage.loadGif(name: "changeTeam")
        startButtonOutlet.layer.borderWidth = 2
        startButtonOutlet.layer.cornerRadius = 5
        startButtonOutlet.layer.borderColor = UIColor.white.cgColor
    }
}
