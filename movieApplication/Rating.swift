//
//  Review.swift
//  movieApplication
//
//  Created by Aqmal on 17/05/2017.
//  Copyright © 2017 Aqmal. All rights reserved.
//

import Foundation

class Rating {
    var userID: String
    var movieID: String
    var rating: Double
    var ratingID: String?
    var ratingDescription: String?
    
    init(userID: String, movieID: String, rating: Double,ratingDescription: String?) {
        self.userID = userID
        self.movieID = movieID
        self.rating = rating
        self.ratingDescription = ratingDescription ?? nil
    }
    func getJSONDataRating() -> Data {
        let dictA: Dictionary = [
            "star" : self.rating,
            "ratingDescription" : (self.ratingDescription) ?? ""
        ] as [String : AnyObject]
        
        let convertedData: Data = try! JSONSerialization.data(withJSONObject: dictA, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        
        return convertedData
    }
    func getJSONDataMovieID() -> Data {
        let arrA: [String] = [movieID]
        let jsonData: Data = try! JSONSerialization.data(withJSONObject: arrA, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        
        
        return jsonData
    }
    func getJSONDataUserID() -> Data {
        let arrA: [String] = [userID]
        let jsonData: Data = try! JSONSerialization.data(withJSONObject: arrA, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        return jsonData
    }
}
