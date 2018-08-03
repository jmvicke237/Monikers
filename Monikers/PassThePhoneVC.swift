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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gifImage.loadGif(name: "changeTeam")

        // Do any additional setup after loading the view.
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
