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

class Monikers {
    let cardNumberMultiplier = 1
    
    var roundOneGuesses = 0
    let teamOne: Team
    let teamTwo: Team
    var namesArray = [String]()
    var skipArray = [String]()
    var answeredArray = [String]()
    var undoStack = [String]()
    var numberOfPlayers = 0
    var winner = ""
    var kindOfUndo: KindOfUndo = .correct
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
    var roundScore = 0
    var endOfRound = false
    var time = 60 {
        didSet {
            timeIncrementDelegate?.timeDidChange()
        }
    }
    
    var turnInProgress = false
    
    var timeIncrementDelegate: timeDelegate? = nil
    var roundChangeDelegate: roundDelegate? = nil
    var teamChangeDelegate: teamDelegate? = nil
    
    var timer = Timer()
    
    init(teamOne nameOne: String, teamTwo nameTwo: String) {
        teamOne = Team(nameOne)
        teamTwo = Team(nameTwo)
        currentTeam = teamOne
        currentRound = .roundOne
        importNamesFromFile()
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
        if currentRound == .roundOne && answeredArray.count == cardNumberMultiplier * numberOfPlayers {
            roundOneGuesses = 0
            endOfRound = true
            namesArray.removeAll()
            namesArray = answeredArray
            answeredArray.removeAll()
            skipArray.removeAll()
            currentRound = .roundTwo
            determineNextTeam()
            endOfRound = false
            return
        }
        
        if namesArray.count == 0 && skipArray.count == 0 {
            endOfRound = true
            namesArray = answeredArray
            answeredArray.removeAll()
            
            switch currentRound {
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
            determineNextTeam()
            endOfRound = false
            return
        } else {
            determineNextTeam()
            for name in skipArray {
                if !namesArray.contains(name) {
                    namesArray.append(name)
                }
            }
            skipArray.removeAll()
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
        if currentRound == .roundOne {
            roundOneGuesses += 1
        }
        if roundOneGuesses == cardNumberMultiplier * numberOfPlayers {
            namesArray.removeAll()
            time = 0
        }
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
                roundOneGuesses -= 1
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
    
    func importNamesFromFile() {
        let path = Bundle.main.path(forResource: "Names", ofType: "txt")
        let filemgr = FileManager.default
        if filemgr.fileExists(atPath: path!) {
            do {
                let fullText = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
                namesArray = fullText.components(separatedBy: "\n")
                namesArray.remove(at: namesArray.count - 1)
            }
            catch { print("Can't read from file/file does not exist") }
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
