//
//  MovieDetailViewController.swift
//  movieApplication
//
//  Created by Aqmal on 16/05/2017.
//  Copyright © 2017 Aqmal. All rights reserved.
//

import UIKit
import Cosmos

protocol addedReviewDelegate {
    func didAddReview(vc: MovieDetailViewController)
}
class MovieDetailViewController: UIViewController {
    var movieSelected: Movie?
    var selectedMovieRating: Double?
    var ratingList: [Rating]?
    
    @IBOutlet weak var addReviewButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var avgRating: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UItweak()
        let defaults: UserDefaults = UserDefaults.standard
        let userID: String = defaults.object(forKey: "loggedInUserID") as! String
        var userReviewed: Bool = false
        for ratingItem in ratingList! {
            if ratingItem.userID == userID {
                if ratingItem.movieID == movieSelected?.id {
                    userReviewed = true
                }   
            }
        }
        
        if userReviewed {
            addReviewButton.setTitle("Reviewed", for: .normal)
            addReviewButton.isEnabled = false
        }
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
        popUpReviewVC.delegate = self
        popUpReviewVC.movieID = movieSelected?.id
        
    }
    func UItweak() {
        self.view.backgroundColor = UIColor.black
        imageLabel.image = movieSelected?.poster
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dateLabel.text = dateFormatter.string(from: (movieSelected?.releaseDate)!)
        dateLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = movieSelected?.title
        titleLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.text = movieSelected?.description
        descriptionLabel.allowsEditingTextAttributes = false
        avgRating.rating = selectedMovieRating!
        avgRating.settings.updateOnTouch = false
    }
    var delegate: addedReviewDelegate?
}
extension MovieDetailViewController: AddReviewDelegate {
  
    func didAddReview(vc: PopUpAddReviewViewController) {
        _ = navigationController?.popToRootViewController(animated: true)
        self.delegate?.didAddReview(vc: self)
    }
}

