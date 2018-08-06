//
//  NewGameVC.swift
//  Monikers
//
//  Created by Justin Vickers on 8/2/18.
//  Copyright © 2018 Justin Vickers. All rights reserved.
//

import UIKit

class NewGameVC: UIViewController {

    @IBOutlet weak var doneButtonOutlet: UIButton!
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        doneButtonOutlet.layer.borderWidth = 2
        doneButtonOutlet.layer.cornerRadius = 5
        doneButtonOutlet.layer.borderColor = UIColor.white.cgColor
    }

}
