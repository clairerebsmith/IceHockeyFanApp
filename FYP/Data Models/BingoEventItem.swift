//
//  GameEvent.swift
//  FYP
//
//  Created by Project  on 02/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit

class BingoEventItem {
    var type: String
    var player: String
    var period: String
    var id: String
    var fixtureID: String
    var selected: Bool
    
    init(type: String, player: String, period: String, id: String, fixtureID: String, selected: Bool) {
        self.type = type
        self.player = player
        self.period = period
        self.id = id
        self.fixtureID = fixtureID
        self.selected = selected
    }
}
