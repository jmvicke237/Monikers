//
//  ViewController.swift
//  Monikers
//
//  Created by Justin Vickers on 7/6/18.
//  Copyright © 2018 Justin Vickers. All rights reserved.
//

import UIKit

class ViewController: UIViewController, timeDelegate, roundDelegate, teamDelegate, turnDelegate {
    
    func timeDidChange() {
        updateTimer()
    }
    
    func roundDidChange() {
        updateRound()
    }
    
    func teamDidChange() {
        updateTeam()
    }
    
    func turnDidChange() {
        updateTurnChangeInstructions()
    }
    
    lazy var game = Monikers(teamOne: teamOneName, teamTwo: teamTwoName, namesArray)
    var namesArray = [String]()
    let selection = UISelectionFeedbackGenerator()
//    var numberOfPlayers = 0
    var teamOneName = ""
    var teamTwoName = ""
    var paused = false
    var rotationDivsor: CGFloat!
    var storedPause = ""

    @IBOutlet weak var cardsRemaining: UILabel!
    @IBOutlet weak var pauseButtonLabel: UIButton!
    @IBOutlet weak var monikersCardBack: MonikerCardBackView!
    @IBOutlet weak var mainCard: MonikersCardView!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var currentTeamGIF: UIImageView!
    @IBOutlet weak var startButtonLabel: UIButton!
    @IBOutlet weak var changeTeamGIF: UIImageView!
    @IBOutlet weak var startGameOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.timeIncrementDelegate = self
        game.teamChangeDelegate = self
        game.roundChangeDelegate = self
        game.turnChangeDelegate = self
        nameLabel.text = ""
        currentTeamGIF.loadGif(name: teamOneName + "-play")
        roundLabel.text = game.currentRound.rawValue
        timerLabel.text = ("\(game.time)")
//        game.numberOfPlayers = numberOfPlayers
        mainCard.alpha = 0
        mainCard.center = self.view.center
        rotationDivsor = (view.frame.width / 2) / 0.61 //degree of tilt expressed in radians
        changeTeamGIF.isHidden = true
        cardsRemaining.text = "\(namesArray.count)"//"\((game.cardNumberMultiplier * game.numberOfPlayers) - game.roundOneGuesses)"
        startGameOutlet.layer.borderWidth = 2
        startGameOutlet.layer.cornerRadius = 5
        startGameOutlet.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func pauseButton(_ sender: UIButton) {
        if game.turnInProgress {
            if !game.pause() {
                pauseButtonLabel.setTitle(">", for: .normal)
                storedPause = nameLabel.text!
                nameLabel.text = "PAUSED"
                UIView.transition(with: mainCard, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                UIView.animate(withDuration: 0.3, animations: {
                    self.mainCard.alpha = 1
                })
            } else {
                pauseButtonLabel.setTitle("||", for: .normal)
                UIView.transition(with: mainCard, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                UIView.animate(withDuration: 0.3, animations: {
                    self.mainCard.alpha = 1
                })
                nameLabel.text = storedPause
            }
        }
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        if !game.turnInProgress && !paused {
            if !changeTeamGIF.isHidden {
                changeTeamGIF.isHidden = true
            }
            game.startTurn()
            UIView.transition(with: mainCard, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
            self.drawNewCard()
            UIView.animate(withDuration: 0.3, animations: {
                self.mainCard.alpha = 1
            })
        }
    }
    
    private func updateTimer() {
        timerLabel.text = ("\(game.time)")
    }
    
    private func updateRound() {
        //mainCard.alpha = 0
        cardsRemaining.text = "\(game.namesArray.count)" //This is very bad coding. It should all be done through updateRemainingCards()
        roundLabel.text = game.currentRound.rawValue
        nameLabel.text = "End of Round! \n Pass the phone and begin \(game.currentRound.rawValue)!"
        UIView.transition(with: self.mainCard, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
        UIView.animate(withDuration: 0.3, animations: {
            self.mainCard.alpha = 1
        })
        changeTeamGIF.loadGif(name: "changeTeam")
        if changeTeamGIF.isHidden{
            changeTeamGIF.isHidden = false
        }
        
        if game.currentRound == .gameOver {
            self.performSegue(withIdentifier: "GameOverSegue", sender:self)
        }
    }
    
    private func updateTurnChangeInstructions() {
        cardsRemaining.text = "\(game.namesArray.count)"
        nameLabel.text = "End of Turn! \n Pass the phone!"
    }
    
    private func updateTeam() {
        //mainCard.alpha = 0
        UIView.transition(with: self.mainCard, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
        UIView.animate(withDuration: 0.3, animations: {
            self.mainCard.alpha = 1
        })
        changeTeamGIF.loadGif(name: "changeTeam")
        if changeTeamGIF.isHidden{
            changeTeamGIF.isHidden = false
        }
        
        currentTeamGIF.loadGif(name: game.currentTeam.name + "-play")
    }

    @IBAction func reset(_ sender: UIButton) {
    }
    
    @IBAction func panMonikersCard(_ sender: UIPanGestureRecognizer) {
        if game.turnInProgress && !paused {
            let card = sender.view! as! MonikersCardView
            let point = sender.translation(in: view)
            let xFromCenter = card.center.x - view.center.x
            let scaleSwipedCard = min(150 / abs(xFromCenter), 1)
            let scaleBackCard = 0.9 + (abs(xFromCenter * 0.00066667))
            
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            card.transform = CGAffineTransform(rotationAngle: xFromCenter / rotationDivsor).scaledBy(x: scaleSwipedCard, y: scaleSwipedCard)
            if abs(xFromCenter) > 150 {
                monikersCardBack.transform = CGAffineTransform.identity
            } else {
                monikersCardBack.transform = CGAffineTransform(scaleX: scaleBackCard, y: scaleBackCard)
            }
            
            
            if xFromCenter > 0 {
                thumbImageView.image = #imageLiteral(resourceName: "ThumpUp")
                thumbImageView.tintColor = UIColor.green
            } else {
                thumbImageView.image = #imageLiteral(resourceName: "ThumpDown")
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
                        self.game.wrongGuess(self.nameLabel.text!)
                        self.drawNewCard()
//                        if self.game.currentRound != .roundOne {
                            self.updateCardsRemaining()
//                        }
                        if self.nameLabel.text != nil {
                            UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                            UIView.animate(withDuration: 0.3, animations: {
                            card.alpha = 1
                            })
                        }
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
                        self.game.correctGuess(self.nameLabel.text!)
                        self.drawNewCard()
                        self.updateCardsRemaining()
                        if self.nameLabel.text != nil {
                            UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                            UIView.animate(withDuration: 0.3, animations: {
                                card.alpha = 1
                            })
                        }
                    })
                    return
                }
                
                UIView.animate(withDuration: 0.2, animations: {
                    card.center = self.view.center
                    card.transform = CGAffineTransform.identity
                    self.monikersCardBack.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                })
                self.thumbImageView.alpha = 0
            }
        }
    }
    
    private func updateCardsRemaining() {
//        if game.currentRound != .roundOne {
            cardsRemaining.text = "\(game.namesArray.count + 1)"
//        } else {
//            let cardsLeftRoundOne = (game.cardNumberMultiplier * game.numberOfPlayers) - game.roundOneGuesses
//            cardsRemaining.text = "\(cardsLeftRoundOne)"
//        }
    }
    
    @IBAction func undoButton(_ sender: UIButton) {
        if !game.undoStack.isEmpty {
            game.namesArray.append(nameLabel.text!)
            nameLabel.text = game.undoStack[0]
            game.undo()
        }
    }
    private func drawNewCard() {
        if let name = game.draw() {
            nameLabel.text = name
        } else {
            mainCard.alpha = 0
            game.time = 0
            nameLabel.text = nil
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameOverSegue" {
            if let destinationVC = segue.destination as? EndGameVC {
                destinationVC.teamOneName = game.teamOne.name
                destinationVC.teamTwoName = game.teamTwo.name
                destinationVC.teamOnePoints = game.teamOne.score
                destinationVC.teamTwoPoints = game.teamTwo.score
                destinationVC.winner = game.winner
            }
        }
    }
 }

