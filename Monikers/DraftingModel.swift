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
    let draftsize = 20
    
    var dataTrackerDictionary = [String: [Int]]()
    var dataTrackerArray = [String]()
    
    init() {
//        importNamesFromFile()
        createDataDictionary()
        createNewDraftingArray()
    }
    
    func  createDataDictionary() {
        let path = Bundle.main.path(forResource: "DataTracker", ofType: "txt")
        let filemgr = FileManager.default
        if filemgr.fileExists(atPath: path!) {
            do {
                let fullText = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
                dataTrackerArray = fullText.components(separatedBy: "\n")
            }
            catch { print("Can't read from file/file does not exist") }
        }
        for card in dataTrackerArray {
            let tempCard = card
            let result = tempCard.split(separator: ",")
            let name = String(result[0])
            let seen = Int(result[1])
            let drafted = Int(result[2])
            var tempValues = [Int]()
            tempValues.append(seen!)
            tempValues.append(drafted!)
            dataTrackerDictionary[name] = tempValues
        }
        for names in dataTrackerDictionary.keys {
            namesArray.append(names)
        }
        print(dataTrackerDictionary)
    }
    
    func convertDictionaryToString() {
        var tempArray = [String]()
        for entry in dataTrackerDictionary.keys {
            let tempValue = dataTrackerDictionary[entry]
            let seen = String(tempValue![0])
            let drafted = String(tempValue![1])
            let tempEntry = "\(entry),\(seen),\(drafted)"
            tempArray.append(tempEntry)
        }
        var newDataTrackerString = ""
        for entry in tempArray {
            newDataTrackerString += "\(entry)\n"
        }
        print(newDataTrackerString)
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
        let newName = currentDraftingArray.remove(at: 0)
        var oldValue = dataTrackerDictionary[newName]
        oldValue![0] += 1
        dataTrackerDictionary[newName] = oldValue!
        
        return newName
    }
    
    func skipCard(_ name: String) {
        currentDraftingArray.append(name)
    }
    
    func acceptCard(_ name: String) {
        var oldValue = dataTrackerDictionary[name]
        oldValue![1] += 1
        dataTrackerDictionary[name] = oldValue!
        
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
