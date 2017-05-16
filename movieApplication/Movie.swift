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
    
    
}

    
