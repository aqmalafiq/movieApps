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
    //var releaseDate: Date
    var poster: UIImage?
    var posterURL: String
   
    init(id:String,title: String,description: String,duration: Int,posterURL: String) {
        self.id = id
        self.title = title
        self.description = description
        self.duration = duration
       // self.releaseDate = releaseDate
        self.posterURL = posterURL
        }
    
    func downloadPicTask(posterURL: String,completionBlock: @ escaping ((_ posterImage: UIImage,_ success: Bool,_ error: Error?) -> Void)){
        let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
        let url: URL = URL.init(string: posterURL)!
        
        let downloadPicTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            //code
            
            let httpCode: Int = (response as! HTTPURLResponse).statusCode
            let image: UIImage = UIImage(data: data!, scale: 1.0)!
            if httpCode == 200 {
                
                DispatchQueue.main.async {
                    completionBlock(image,true,nil)
                }
                
            } else {
                DispatchQueue.main.async {
                    completionBlock(image,true,nil)
                }
            }
        }
        downloadPicTask.resume()
    }

}

    
