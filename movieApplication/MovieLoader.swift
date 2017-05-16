//
//  MovieLoader.swift
//  movieApplication
//
//  Created by Aqmal on 15/05/2017.
//  Copyright © 2017 Aqmal. All rights reserved.
//

import Foundation
import UIKit

class MovieLoader {
    static let sharedLoader: MovieLoader = MovieLoader()
    
    var session: URLSession
    var targetURL: URL
    var config: URLSessionConfiguration
    
    init() {
        targetURL = URL(string: "https://api.backendless.com/BF6BE502-B2CE-A1AE-FF7E-85A993A6E800/909ABC61-6AE9-EF64-FFBE-49150A269200/data/Movie")!
        self.config = URLSessionConfiguration.default
        self.session = URLSession(configuration: config)
    }
}
extension MovieLoader {
    func retrieveMovieList(completionBlock: @escaping ((_ movieList: [Movie],_ success: Bool,_ error: Error?) -> Void)) {
        
        var movieList: [Movie] = []
        
        let dataTask: URLSessionDataTask = self.session.dataTask(with: targetURL) { (data: Data?, response: URLResponse?, error: Error?) in
            //code
            let jsonData: [[String : AnyObject]] = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as! [[String : AnyObject]]
            
            for jsonItem in jsonData {
                
                let id: String = jsonItem["objectId"] as! String
                let title: String = jsonItem["title"] as! String
                let duration: Int = jsonItem["duration"] as! Int
                let posterURL:  String = jsonItem["image"] as! String
               // let releaseDate: Date = jsonItem["releaseDate"] as! Date
                let description: String = jsonItem["description"] as! String
                
                let newMovie: Movie = Movie(id: id,title: title,description: description,duration: duration,posterURL: posterURL)
                movieList.append(newMovie)
                
            }
            let httpCode : Int = (response as! HTTPURLResponse).statusCode
            if httpCode == 200 {
                DispatchQueue.main.async {
                    completionBlock(movieList,true,nil)
                }
            } else {
                DispatchQueue.main.async {
                    completionBlock(movieList,false,nil)
                }
                
                print ("error")
            }
        }
        dataTask.resume()
    }//end of file retrieval
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
