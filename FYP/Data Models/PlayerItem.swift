//
//  PlayerItem.swift
//  FYP
//
//  Created by Project  on 02/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit

class PlayerItem {
    var name: String
    var number: String
    var country: String
    var team: String
    var age: String
    
    init(name: String, number: String, country: String, team:String, age: String) {
        self.name = name
        self.number = number
        self.country = country
        self.team = team
        self.age = age
        
    }
}
