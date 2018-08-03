//
//  MenuVC.swift
//  Monikers
//
//  Created by Justin Vickers on 8/2/18.
//  Copyright © 2018 Justin Vickers. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
    
    @IBOutlet weak var settingsOUtlet: UIButton!
    @IBOutlet weak var newGameOutlet: UIButton!
    @IBOutlet weak var howToPlayOutlet: UIButton!
    @IBOutlet weak var mainCardOutlet: DraftCardView!
    @IBOutlet weak var cardBackOutlet: MonikerCardBackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        border(settingsOUtlet)
        border(newGameOutlet)
        border(howToPlayOutlet)
        mainCardOutlet.alpha = 0
        cardBackOutlet.alpha = 1
    }
    
    func border(_ outlet: UIButton) {
        outlet.layer.borderWidth = 2
        outlet.layer.cornerRadius = 5
        outlet.layer.borderColor = UIColor.white.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
