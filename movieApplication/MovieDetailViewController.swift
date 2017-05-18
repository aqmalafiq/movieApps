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
       /*
        let backImage: UIImageView = UIImageView(image: movieSelected?.poster)
        backImage.frame = view.bounds
        //view.addSubview(backImage)
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = backImage.bounds
        view.addSubview(blurredEffectView)
        view.sendSubview(toBack: self.view)
       //self.view.backgroundColor = UIColor(patternImage: (blurredEffectView))
        */
        self.view.backgroundColor = UIColor.black
        imageLabel.image = movieSelected?.poster
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dateLabel.text = dateFormatter.string(from: (movieSelected?.releaseDate)!)
        dateLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = movieSelected?.title
        titleLabel.adjustsFontSizeToFitWidth = true
        //descriptionLabel.backgroundColor = UIColor.lightGray
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let popUpReviewVC: PopUpAddReviewViewController = segue.destination as! PopUpAddReviewViewController
        popUpReviewVC.movieID = movieSelected?.id
        
    }
 

}
