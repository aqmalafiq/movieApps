//
//  Review.swift
//  movieApplication
//
//  Created by Aqmal on 17/05/2017.
//  Copyright © 2017 Aqmal. All rights reserved.
//

import Foundation

class Rating {
    var userID: String?
    var movieID: String
    var rating: Double
    
    init(userID: String?, movieID: String, rating: Double) {
        self.userID = userID
        self.movieID = movieID
        self.rating = rating
    }
    
   
}
