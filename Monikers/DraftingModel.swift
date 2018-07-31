//
//  DraftingModel.swift
//  Monikers
//
//  Created by Justin Vickers on 7/29/18.
//  Copyright © 2018 Justin Vickers. All rights reserved.
//

import Foundation
class DraftingModel {
    
    var namesArray = [String]()
    var namesForPlayArray = [String]()
    var currentDraftingArray = [String]()
    var currentNumberOfPlayers = 0
    var currentNumberOfCardsSelected = 0
    let draftsize = 10
    
    init() {
        importNamesFromFile()
        createNewDraftingArray()
    }
    
    func createNewDraftingArray() {
        currentDraftingArray.removeAll()
        for _ in 0..<draftsize {
            currentDraftingArray.append(drawFromNamesArray()!)
        }
        currentNumberOfCardsSelected = 0
    }
    
    func drawFromNamesArray() -> String? {
        return namesArray.remove(at: namesArray.count.arc4random)
    }
    
    func drawFromCurrentDraftingArray() -> String? {
        return currentDraftingArray.remove(at: 0)
    }
    
    func skipCard(_ name: String) {
        currentDraftingArray.append(name)
    }
    
    func acceptCard(_ name: String) {
        namesForPlayArray.append(name)
        if namesForPlayArray.count == currentNumberOfPlayers * 5 {
            currentNumberOfCardsSelected += 1
            currentNumberOfPlayers += 1
            return
        }
        currentNumberOfCardsSelected += 1
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
