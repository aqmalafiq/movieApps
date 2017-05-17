//
//  MovieDetailViewController.swift
//  movieApplication
//
//  Created by Aqmal on 16/05/2017.
//  Copyright © 2017 Aqmal. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movieSelected: Movie?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.view.backgroundColor = UIColor(patternImage: (movieSelected?.poster)!)
        
        imageLabel.image = movieSelected?.poster
        dateLabel.text = movieSelected?.releaseDate.description
        titleLabel.text = movieSelected?.title
        descriptionLabel.text = movieSelected?.description
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
 

}
