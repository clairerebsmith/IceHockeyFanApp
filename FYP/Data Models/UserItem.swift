//
//  UserItem.swift
//  FYP
//
//  Created by Project  on 26/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit

class UserItem {
    var email: String
    var password: String
    var name: String
    var id: String
    
    init(email: String, password: String, name:String, id: String) {
        self.email = email
        self.password = password
        self.name = name
        self.id = id
    }
}
