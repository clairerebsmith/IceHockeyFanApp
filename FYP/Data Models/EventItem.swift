//
//  EventItem.swift
//  FYP
//
//  Created by Project  on 02/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit

class EventItem {
    var id: String
    var type: String
    var name: String
    var player: String
    var time: String
    var period: String
    var team: String
    var fixtureID: String
    
    init(id: String, type: String, name: String, player: String, time: String, period: String, team: String, fixtureID: String) {
        self.id = id
        self.type = type
        self.name = name
        self.player = player
        self.time = time
        self.period = period
        self.team = team
        self.fixtureID = fixtureID
    }
}
