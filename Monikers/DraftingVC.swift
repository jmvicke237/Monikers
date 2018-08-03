//
//  DraftingVC.swift
//  Monikers
//
//  Created by Justin Vickers on 7/29/18.
//  Copyright © 2018 Justin Vickers. All rights reserved.
//

import UIKit

class DraftingVC: UIViewController {
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    lazy var draft = DraftingModel()
    var rotationDivsor: CGFloat!
    let selection = UISelectionFeedbackGenerator()
    var teamOneName = ""
    var teamTwoName = ""
    
    @IBOutlet var cardRemainingImage: [UIImageView]!
    @IBOutlet var cardRemainingLabel: [UILabel]!
    @IBOutlet weak var cardBackView: MonikerCardBackView!
    @IBOutlet weak var mainCard: DraftCardView!
    @IBOutlet weak var mainCardLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCard.alpha = 0
        mainCard.center = self.view.center
        cardBackView.alpha = 1
        cardBackView.center = self.view.center
        rotationDivsor = (view.frame.width / 2) / 0.61
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mainCardLabel.text = draft.drawFromCurrentDraftingArray()
        UIView.transition(with: mainCard, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
        UIView.animate(withDuration: 0.3, animations: {
            self.mainCard.alpha = 1
        })
    }
    
    @IBAction func panRecognizer(_ sender: UIPanGestureRecognizer) {
        let card = sender.view! as! DraftCardView
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        let scaleSwipedCard = min(150 / abs(xFromCenter), 1)
        let scaleBackCard = 0.9 + (abs(xFromCenter * 0.00066667))
        
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter / rotationDivsor).scaledBy(x: scaleSwipedCard, y: scaleSwipedCard)
        if abs(xFromCenter) > 150 {
            cardBackView.transform = CGAffineTransform.identity
        } else {
            cardBackView.transform = CGAffineTransform(scaleX: scaleBackCard, y: scaleBackCard)
        }
        
        
        if xFromCenter > 0 {
            thumbImageView.image = UIImage(named: "ThumpUp")
            thumbImageView.tintColor = UIColor.green
        } else {
            thumbImageView.image =  UIImage(named: "ThumpDown")
            thumbImageView.tintColor = UIColor.red
        }
        
        thumbImageView.alpha = abs(xFromCenter) / view.center.x
        
        if sender.state == UIGestureRecognizerState.ended {
            if card.center.x < 75 {
                selection.selectionChanged()
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                    card.alpha = 0
                }, completion: {(finished:Bool) in card.center = self.view.center
                    self.thumbImageView.alpha = 0
                    card.transform = CGAffineTransform.identity
                    self.draft.skipCard(self.mainCardLabel.text!)
                    self.mainCardLabel.text = self.draft.drawFromCurrentDraftingArray()
                    UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                    UIView.animate(withDuration: 0.3, animations: {
                        card.alpha = 1
                    })
                })
                return
            } else if card.center.x > (view.frame.width - 75) {
                selection.selectionChanged()
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                    card.alpha = 0
                }, completion: {(finished:Bool) in card.center = self.view.center
                    self.thumbImageView.alpha = 0
                    card.transform = CGAffineTransform.identity
                    self.cardRemainingImage[self.draft.currentNumberOfCardsSelected].image = UIImage(named: "cardsRemainingWhiteIcon")
                    self.cardRemainingLabel[self.draft.currentNumberOfCardsSelected].alpha = 0
                    self.draft.acceptCard(self.mainCardLabel.text!)
                    if self.draft.currentNumberOfCardsSelected == 5 || self.draft.currentDraftingArray.isEmpty{
                        self.mainCardLabel.text = ""
                        self.draft.createNewDraftingArray()
                        self.performSegue(withIdentifier: "DraftOrPlaySegue", sender:self)
                        for index in 0..<self.cardRemainingImage.count {
                            self.cardRemainingImage[index].image = UIImage(named: "cardsRemainingIcon")
                            self.cardRemainingLabel[index].alpha = 1
                        }
                        return
                    } else {
                            self.mainCardLabel.text = self.draft.drawFromCurrentDraftingArray()
                    }
                    UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                    UIView.animate(withDuration: 0.3, animations: {
                        card.alpha = 1
                    })
                })
                return
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                card.center = self.view.center
                card.transform = CGAffineTransform.identity
                self.cardBackView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
            self.thumbImageView.alpha = 0
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DraftOrPlaySegue" {
            if let destinationVC = segue.destination as? DraftOrPlayVC {
                destinationVC.namesForPlayArray = draft.namesForPlayArray
                destinationVC.teamOneName = teamOneName
                destinationVC.teamTwoName = teamTwoName
            }
        }
    }
    
}
