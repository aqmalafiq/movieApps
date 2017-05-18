//
//  User.swift
//  movieApplication
//
//  Created by Aqmal on 18/05/2017.
//  Copyright © 2017 Aqmal. All rights reserved.
//

import Foundation

class User {
    var userID: String
    var username: String
    var email: String
    var password: String
    
    init(userID: String,username: String,email: String,password: String) {
        self.userID = userID
        self.username = username
        self.email = email
        self.password = password
    }
    
}
