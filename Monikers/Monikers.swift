//
//  Monikers.swift
//  Monikers
//
//  Created by Justin Vickers on 7/7/18.
//  Copyright © 2018 Justin Vickers. All rights reserved.
//

import Foundation
import AudioToolbox

protocol timeDelegate {
    func timeDidChange()
}

protocol roundDelegate {
    func roundDidChange()
}

protocol teamDelegate {
    func teamDidChange()
}

protocol turnDelegate {
    func turnDidChange()
}

class Monikers {
    let cardNumberMultiplier = 1
    var paused = false
    let teamOne: Team
    let teamTwo: Team
    var namesArray = [String]()
    var skipArray = [String]()
    var answeredArray = [String]()
    var undoStack = [String]()
    var winner = ""
    var kindOfUndo: KindOfUndo = .correct
    var roundScore = 0
    var endOfRound = false
    
    var currentTeam: Team {
        didSet {
            teamChangeDelegate?.teamDidChange()
        }
    }
    
    var currentRound: Round {
        didSet {
            roundChangeDelegate?.roundDidChange()
        }
    }
    
    var time = 60 {
        didSet {
            timeIncrementDelegate?.timeDidChange()
        }
    }
    
    var turnNotRoundChanged = false {
        didSet {
            turnChangeDelegate?.turnDidChange()
        }
    }
    
    var turnInProgress = false
    
    var timeIncrementDelegate: timeDelegate? = nil
    var roundChangeDelegate: roundDelegate? = nil
    var teamChangeDelegate: teamDelegate? = nil
    var turnChangeDelegate: turnDelegate? = nil
    
    var timer = Timer()
    
    init(teamOne nameOne: String, teamTwo nameTwo: String, _ names: [String]) {
        teamOne = Team(nameOne)
        teamTwo = Team(nameTwo)
        currentTeam = teamOne
        currentRound = .roundOne
        namesArray = names
    }
    
    func timerStart() {
        turnInProgress = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Monikers.timerDecrement), userInfo: nil, repeats: true)
    }
    
    @objc private func timerDecrement() {
        time -= 1
        if time < 0 {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            AudioServicesPlayAlertSound(SystemSoundID(1322))
            timer.invalidate()
            time = 60
            determineRound()
            turnInProgress = false
        }
    }
    
    func startTurn() {
        timerStart()
    }
    
    private func determineRound() { //Called when the timer hits 0
        
        if namesArray.count == 0 && skipArray.count == 0 {
            endOfRound = true
            namesArray = answeredArray
            answeredArray.removeAll()
            determineNextTeam()
            switch currentRound {
            case .roundOne:
                currentRound = .roundTwo
            case .roundTwo:
                currentRound = .roundThree
                break
            case .roundThree:
                if teamOne.score > teamTwo.score {
                    winner = teamOne.name
                } else if teamOne.score < teamTwo.score {
                    winner = teamTwo.name
                } else {
                    winner = "tie"
                }
                currentRound = .gameOver
                break
            default: break
            }
//            determineNextTeam()
            endOfRound = false
            return
        } else {
            for name in skipArray {
                if !namesArray.contains(name) {
                    namesArray.append(name)
                }
            }
            skipArray.removeAll()
            determineNextTeam()
        }
    }
    
    private func switchTeams() {
        undoStack.removeAll()
        switch currentTeam.name {
        case teamOne.name:
            currentTeam = teamTwo
            break
        case teamTwo.name:
            currentTeam = teamOne
            break
        default: break
        }
    }
    
    private func determineNextTeam() {
        if endOfRound == true {
            if teamOne.score < teamTwo.score {
                currentTeam = teamOne
            } else if teamOne.score > teamTwo.score {
                currentTeam = teamTwo
            } else {
                switchTeams()
            }
        } else {
            switchTeams()
            turnNotRoundChanged = !turnNotRoundChanged
        }
    }
    
    func draw() -> String? {
        if currentRound != .gameOver{
            if namesArray.count > 0 {
                return namesArray.remove(at: namesArray.count.arc4random)
            } else {
                return nil
            }
        } else {
            namesArray.removeAll()
            namesArray.append("Game Over \n \(teamOne.name): \(teamOne.score) \n \(teamTwo.name): \(teamTwo.score)")
            return nil
        }
    }
    
    func correctGuess(_ name: String) {
        undoStack.removeAll()
        undoStack.append(name)
        kindOfUndo = .correct
        answeredArray.append(name)
        currentTeam.score += 1
    }
    
    func wrongGuess(_ name: String) {
        undoStack.removeAll()
        undoStack.append(name)
        kindOfUndo = .skip
        skipArray.append(name)
    }
    
    func undo() {
        if !undoStack.isEmpty {
            switch kindOfUndo {
            case .correct:
                currentTeam.score -= 1
                answeredArray.removeLast()
                undoStack.removeAll()
                break
            case .skip:
                skipArray.removeLast()
                undoStack.removeAll()
                break
            }
        }
    }
    
    func pause() -> Bool {
        if !paused {
            timer.invalidate()
            paused = true
            return false
        } else {
            paused = false
            timerStart()
            return true
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
