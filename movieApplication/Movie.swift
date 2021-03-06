//
//  File.swift
//  movieApplication
//
//  Created by Aqmal on 15/05/2017.
//  Copyright © 2017 Aqmal. All rights reserved.
//

import Foundation
import UIKit

class Movie {
    var id: String
    var title: String
    var description: String
    var duration: Int
    var releaseDate: Date
    var poster: UIImage?
    var posterURL: String
    
   
    init(id:String,title: String,description: String,duration: Int,releaseDate: Date,posterURL: String) {
        self.id = id
        self.title = title
        self.description = description
        self.duration = duration
        self.releaseDate = releaseDate
        self.posterURL = posterURL
        }
    func calculateAvgRating (ratingList: [Rating]) -> Double {
        var totalRating: Double = 0
        var numOfRating: Double = 0
        for ratingItem in ratingList {
            if ratingItem.movieID == self.id {
                totalRating += ratingItem.rating
                numOfRating += 1
            }
        }
        if numOfRating != 0 {
            return (totalRating / numOfRating)
        } else {
            return 0
        }
        
    }
}

    
