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
    
    var game = Monikers()
    let selection = UISelectionFeedbackGenerator()
    var numberOfPlayers = 0
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var currentTeam: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButtonLabel: UIButton!
    
    @IBAction func startButton(_ sender: UIButton) {
        if !game.turnInProgress {
            game.startTurn()
            drawNewCard()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameOverSegue" {
            if let destinationVC = segue.destination as? EndGameVC {
                destinationVC.teamOneName = game.teamOne.name.rawValue
                destinationVC.teamTwoName = game.teamTwo.name.rawValue
                destinationVC.teamOnePoints = game.teamOne.score
                destinationVC.teamTwoPoints = game.teamTwo.score
                destinationVC.winner = "Winner: " + game.winner
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
        currentTeam.text = game.currentTeam.name.rawValue//("\(game.currentTeam.name)")
        roundLabel.text = game.currentRound.rawValue//("\(game.currentRound)")
        timerLabel.text = ("\(game.time)")
        print("Number of Players = \(numberOfPlayers)")
        game.numberOfPlayers = numberOfPlayers
    }
    
    private func updateTimer() {
        timerLabel.text = ("\(game.time)")
    }
    
    private func updateRound() {
        roundLabel.text = game.currentRound.rawValue
        if game.currentRound == .gameOver {
            self.performSegue(withIdentifier: "GameOverSegue", sender:self)
        }
    }
    
    private func updateTeam() {
        currentTeam.text = game.currentTeam.name.rawValue //("\(game.currentTeam.name)")
    }

    @IBAction func reset(_ sender: UIButton) {
    }
    @IBAction func panMonikersCard(_ sender: UIPanGestureRecognizer) {
        if game.turnInProgress {
            let card = sender.view!
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
                    drawNewCard()
                    UIView.animate(withDuration: 0.3, animations: {
                        card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                        card.alpha = 0
                    }, completion: {(finished:Bool) in card.center = self.view.center
                        self.thumbImageView.alpha = 0
                        UIView.animate(withDuration: 0.3, animations: {
                        card.alpha = 1
                        })
                    })
                    return
                } else if card.center.x > (view.frame.width - 75) {
                    selection.selectionChanged()
                    game.correctGuess(nameLabel.text!)
                    drawNewCard()
                    UIView.animate(withDuration: 0.3, animations: {
                        card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                        card.alpha = 0
                    }, completion: {(finished:Bool) in card.center = self.view.center
                        self.thumbImageView.alpha = 0
                        UIView.animate(withDuration: 0.3, animations: {
                            card.alpha = 1
                        })
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
            nameLabel.text = game.undoStack[0]
            game.undo()
        }
    }
    private func drawNewCard() {
        if let name = game.draw() {
            nameLabel.text = name
        } else {
            game.time = 0
            nameLabel.text = ""
        }
    }
 }

