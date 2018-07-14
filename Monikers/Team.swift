//
//  Team.swift
//  Monikers
//
//  Created by Justin Vickers on 7/7/18.
//  Copyright © 2018 Justin Vickers. All rights reserved.
//

import Foundation

class Team {
    var name: String
    var score = 0
    var isMyTurn = false
    
    init(_ name: String) {
        self.name = name
    }
}
