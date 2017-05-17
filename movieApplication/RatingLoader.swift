//
//  RatingLoader.swift
//  movieApplication
//
//  Created by Aqmal on 17/05/2017.
//  Copyright © 2017 Aqmal. All rights reserved.
//

import Foundation

class RatingLoader {
    static let sharedLoader: RatingLoader = RatingLoader()
    
    var session: URLSession
    var targetURL: URL
    var config: URLSessionConfiguration
    
    init() {
        targetURL = URL(string: "https://api.backendless.com/BF6BE502-B2CE-A1AE-FF7E-85A993A6E800/909ABC61-6AE9-EF64-FFBE-49150A269200/data/Rating")!
        self.config = URLSessionConfiguration.default
        self.session = URLSession(configuration: config)
    }
}
extension RatingLoader {
    func retrieveRatingList(completionBlock: @escaping ((_ ratingList: [Rating],_ success: Bool,_ error: Error?) -> Void)) {
        
        var ratingList : [Rating] = []
        let dataTask: URLSessionDataTask = self.session.dataTask(with: targetURL) { (data: Data?, response: URLResponse?, error: Error?) in
            //code
            let jsonData: [[String : AnyObject]] = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as! [[String : AnyObject]]
            
            for jsonItem in jsonData {
                
                let rating: Double = jsonItem["star"] as! Double
                let movieInfo: [[String : AnyObject]] = jsonItem["movieID"] as! [[String : AnyObject]]
                
                for movieItem in movieInfo {
                    let movieID: String = movieItem["objectId"] as! String
                    
                    let newRating: Rating = Rating.init(userID: nil, movieID: movieID, rating: rating)
                    ratingList.append(newRating)
                }
            }
            let httpCode : Int = (response as! HTTPURLResponse).statusCode
            if httpCode == 200 {
                DispatchQueue.main.async {
                    completionBlock(ratingList,true,nil)
                }
            } else {
                DispatchQueue.main.async {
                    completionBlock(ratingList,false,nil)
                }
                print ("error")
            }
        }
        dataTask.resume()
    }//end of file retrieval
    
}
