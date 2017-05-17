//
//  MovieDetailViewController.swift
//  movieApplication
//
//  Created by Aqmal on 16/05/2017.
//  Copyright © 2017 Aqmal. All rights reserved.
//

import UIKit
import Cosmos
class MovieDetailViewController: UIViewController {

    var movieSelected: Movie?
    var selectedMovieRating: Double?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var avgRating: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.view.backgroundColor = UIColor(patternImage: (movieSelected?.poster)!)
        
        imageLabel.image = movieSelected?.poster
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dateLabel.text = dateFormatter.string(from: (movieSelected?.releaseDate)!)
        titleLabel.text = movieSelected?.title
        descriptionLabel.backgroundColor = UIColor.lightGray
        descriptionLabel.text = movieSelected?.description
        descriptionLabel.allowsEditingTextAttributes = false
        avgRating.rating = selectedMovieRating!
        avgRating.settings.updateOnTouch = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
 

}
