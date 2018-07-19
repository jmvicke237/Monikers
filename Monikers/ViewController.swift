//
//  ViewController.swift
//  Monikers
//
//  Created by Justin Vickers on 7/6/18.
//  Copyright © 2018 Justin Vickers. All rights reserved.
//

import UIKit

class ViewController: UIViewController, timeDelegate, roundDelegate, teamDelegate {
    
    func timeDidChange() {
        updateTimer()
    }
    
    func roundDidChange() {
        updateRound()
    }
    
    func teamDidChange() {
        updateTeam()
    }
    
    lazy var game = Monikers(teamOne: teamOneName, teamTwo: teamTwoName)
    let selection = UISelectionFeedbackGenerator()
    var numberOfPlayers = 0
    var teamOneName = ""
    var teamTwoName = ""
    var paused = false
    @IBOutlet weak var pauseButtonLabel: UIButton!
    
    @IBOutlet weak var mainCard: MonikersCardView!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var currentTeamGIF: UIImageView!
    @IBOutlet weak var startButtonLabel: UIButton!
    
    @IBAction func pauseButton(_ sender: UIButton) {
        if !paused {
            game.timer.invalidate()
            pauseButtonLabel.setTitle(">", for: .normal)
            paused = true
        } else {
            paused = false
            game.timerStart()
            pauseButtonLabel.setTitle("||", for: .normal)
        }
        
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        print("START!!!!")
        if !game.turnInProgress {
            game.startTurn()
            UIView.transition(with: mainCard, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
            self.drawNewCard()
            UIView.animate(withDuration: 0.3, animations: {
                self.mainCard.alpha = 1
            })
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
                print(game.winner)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.timeIncrementDelegate = self
        game.teamChangeDelegate = self
        game.roundChangeDelegate = self
        nameLabel.text = ""
        currentTeamGIF.loadGif(name: teamOneName + "-play")
        roundLabel.text = game.currentRound.rawValue
        timerLabel.text = ("\(game.time)")
        print("Number of Players = \(numberOfPlayers)")
        game.numberOfPlayers = numberOfPlayers
        mainCard.alpha = 0
        mainCard.center = self.view.center
    }
    
    private func updateTimer() {
        timerLabel.text = ("\(game.time)")
    }
    
    private func updateRound() {
        mainCard.alpha = 0
        roundLabel.text = game.currentRound.rawValue
        if game.currentRound == .gameOver {
            self.performSegue(withIdentifier: "GameOverSegue", sender:self)
        }
    }
    
    private func updateTeam() {
        mainCard.alpha = 0
        currentTeamGIF.loadGif(name: game.currentTeam.name + "-play")
    }

    @IBAction func reset(_ sender: UIButton) {
    }
    
    @IBAction func panMonikersCard(_ sender: UIPanGestureRecognizer) {
        if game.turnInProgress {
            let card = sender.view! as! MonikersCardView
            let point = sender.translation(in: view)
            let xFromCenter = card.center.x - view.center.x
            
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            
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
                    game.wrongGuess(nameLabel.text!)
                    UIView.animate(withDuration: 0.3, animations: {
                        card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                        card.alpha = 0
                    }, completion: {(finished:Bool) in card.center = self.view.center
                        self.thumbImageView.alpha = 0
                        
                        self.drawNewCard()
                        print("text = " + self.nameLabel.text!)
                        if self.nameLabel.text != "names empty" {
                            print("FLIPPING!!!")
                            UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                            
                            
                            
                            UIView.animate(withDuration: 0.3, animations: {
                            card.alpha = 1
                            })
                        }
                    })
                    return
                } else if card.center.x > (view.frame.width - 75) {
                    selection.selectionChanged()
                    game.correctGuess(nameLabel.text!)
                    UIView.animate(withDuration: 0.3, animations: {
                        card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                        card.alpha = 0
                    }, completion: {(finished:Bool) in card.center = self.view.center
                        self.thumbImageView.alpha = 0
                        
                        self.drawNewCard()
                        print("text = " + self.nameLabel.text!)
                        if self.nameLabel.text != "names empty" {
                            print("FLIPPING!!!")
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
                })
                self.thumbImageView.alpha = 0
            }
        }
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
            nameLabel.text = "names empty"
        }
    }
 }

