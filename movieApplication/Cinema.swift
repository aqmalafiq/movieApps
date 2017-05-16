//
//  Review.swift
//  movieApplication
//
//  Created by Aqmal on 15/05/2017.
//  Copyright © 2017 Aqmal. All rights reserved.
//

import Foundation

class Cinema {
    var id: String
    var name: String
    var location: String
    var hall: Int
    
    init(id: String,name: String,location: String,hall: Int) {
        self.id = id
        self.name = name
        self.location = location
        self.hall = hall
    }
}
