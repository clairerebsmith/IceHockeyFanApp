//
//  FixtureItem.swift
//  FYP
//
//  Created by Project  on 02/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit

class FixtureItem {
    var id: String
    var homeTeam: String
    var awayTeam: String
    var date: String
    var time: String
    var active: Bool
    
    init(id: String, homeTeam: String, awayTeam: String, date: String, time: String, active: Bool) {
        self.id = id
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.date = date
        self.time = time
        self.active = active
    }
}
