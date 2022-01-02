//
//  TicketSOHBItem.swift
//  FYP
//
//  Created by Project  on 27/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit

class TicketSOHBItem {
    var id: String
    var owner: String
    var fixtureID: String
    
    init(id: String, owner: String, fixtureID: String) {
        self.id = id
        self.owner = owner
        self.fixtureID = fixtureID
    }
}
