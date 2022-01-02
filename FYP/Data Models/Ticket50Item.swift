//
//  Ticket50Item.swift
//  FYP
//
//  Created by Project  on 10/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit

class Ticket50Item {
    var id: String
    var owner: String
    var fixtureID: String
    var won: Bool
    
    init(id: String, owner: String, fixtureID: String, won: Bool) {
        self.id = id
        self.owner = owner
        self.fixtureID = fixtureID
        self.won = won
    }
}
