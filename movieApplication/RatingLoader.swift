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
                let ratingDescription: String = jsonItem["ratingDescription"] as? String ?? ""
                let movieInfo: [String : AnyObject] = jsonItem["movieID"] as! [String : AnyObject]
                let movieID: String = movieInfo["objectId"] as! String
                let userInfo: [String : AnyObject] = jsonItem["userID"] as! [String : AnyObject]
                let userID: String = userInfo["objectId"] as! String
                let newRating: Rating = Rating.init(userID: userID, movieID: movieID, rating: rating, ratingDescription: ratingDescription)
                    ratingList.append(newRating)
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
    func postNewRating(newRating: Rating, completionBlock: @escaping ((_ success: Bool, _ error: Error?) -> Void)) {
        var urlRequest: URLRequest = URLRequest(url: targetURL)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = newRating.getJSONDataRating()
        let postTask: URLSessionDataTask = self.session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            
            let httpCode: Int = (response as! HTTPURLResponse).statusCode
            if httpCode == 200 || httpCode == 201 {
                let jsonData: [String : AnyObject] = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as! [String : AnyObject]
                let ratingID: String = jsonData["objectId"] as! String
                newRating.ratingID = ratingID
                self.postNewRatingAddRelationMovieIDColumn(newRating: newRating, completionBlock: { (success: Bool, error: Error?) in
                    //code
                    self.postNewRatingAddRelationUserIDColumn(newRating: newRating, completionBlock: { (success: Bool, error: Error?) in
                        //code
                         completionBlock(true, nil)
                    })
                })
            } else {
                completionBlock(false, nil)
            }
        }
        postTask.resume()
    }//end of file post
    func postNewRatingAddRelationMovieIDColumn(newRating: Rating, completionBlock: @escaping ((_ success: Bool,_ error: Error?) -> Void)) {
        var newTargetURL: URL = targetURL.appendingPathComponent(newRating.ratingID!)
        newTargetURL = newTargetURL.appendingPathComponent("movieID")
        var urlRequest: URLRequest = URLRequest(url: newTargetURL)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = newRating.getJSONDataMovieID()
        
        let postTask: URLSessionDataTask = self.session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            let httpCode: Int = (response as! HTTPURLResponse).statusCode
            if httpCode == 200 {
                completionBlock(true, nil)
            } else {
                completionBlock(false, nil)
            }
        }
        postTask.resume()
    }
    func postNewRatingAddRelationUserIDColumn(newRating: Rating, completionBlock: @escaping ((_ success: Bool,_ error: Error?) -> Void)) {
        var newTargetURL: URL = targetURL.appendingPathComponent(newRating.ratingID!)
        newTargetURL = newTargetURL.appendingPathComponent("userID")
        var urlRequest: URLRequest = URLRequest(url: newTargetURL)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = newRating.getJSONDataUserID()
        
        let postTask: URLSessionDataTask = self.session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            let httpCode: Int = (response as! HTTPURLResponse).statusCode
            if httpCode == 200 {
                completionBlock(true, nil)
            } else {
                completionBlock(false, nil)
            }
        }
        postTask.resume()
    }
}
