//
//  PopUpAddReviewViewController.swift
//  movieApplication
//
//  Created by Aqmal on 18/05/2017.
//  Copyright © 2017 Aqmal. All rights reserved.
//

import UIKit
import Cosmos

protocol AddReviewDelegate {
    func didAddReview(vc: PopUpAddReviewViewController)
}

class PopUpAddReviewViewController: UIViewController {
    
    var movieID: String?

    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet weak var ratingDescription: UITextField!
    @IBOutlet var tapOutside: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        starRating.settings.fillMode = .half
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  var delegate: AddReviewDelegate?
    
    @IBAction func dissmissingTouch(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func submitButton(_ sender: Any) {
        let defaults: UserDefaults = UserDefaults.standard
        let userID: String = defaults.object(forKey: "loggedInUserID") as! String
        let newRating: Rating = Rating.init(userID: userID, movieID: movieID!, rating: starRating.rating, ratingDescription: (ratingDescription.text) ?? "")
        RatingLoader.sharedLoader.postNewRating(newRating: newRating) { (success: Bool, error: Error?) in
           
        }
        self.delegate?.didAddReview(vc: self)
    }
    
}

