//
//  ViewController.swift
//  movieApplication
//
//  Created by Aqmal on 16/05/2017.
//  Copyright © 2017 Aqmal. All rights reserved.
//
import Foundation
import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [Movie] = []
    var ratingList: [Rating] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //this is what the storyboard do if you drag and drop the de
        //        self.collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "movieCell")
        //        self.collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
        self.view.backgroundColor = UIColor.black
        refreshMovieList()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func refreshMovieList() {
        MovieLoader.sharedLoader.retrieveMovieList { (movieList: [Movie], success: Bool, error: Error?) in
            self.movies = movieList
            self.collectionView.reloadData()
            for movie in self.movies { //download pic poster
                MovieLoader.sharedLoader.downloadPicTask(posterURL: movie.posterURL, completionBlock: { (image: UIImage, success: Bool, error: Error?) in
                    movie.poster = image
                    self.collectionView.reloadData()
                })
            }
        }
        RatingLoader.sharedLoader.retrieveRatingList { (ratingList: [Rating], success: Bool, error: Error?) in //load rating from server
            self.ratingList = ratingList
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movieDetailVC: MovieDetailViewController = segue.destination as! MovieDetailViewController
        let movieIndex: Int = (sender as? Int)!
        movieDetailVC.movieSelected = movies[movieIndex]
        movieDetailVC.selectedMovieRating = movies[movieIndex].calculateAvgRating(ratingList: ratingList)
        
    }
}
extension MovieListViewController: UICollectionViewDelegate { //collectionview cell button action
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("item \(indexPath.row) was selected")
        let movieIndex: Int = indexPath.row
        performSegue(withIdentifier: "showMovieDetailSegue", sender: movieIndex)
    }
    
}

extension MovieListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        debugPrint(movies.count)
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //code
        let cell : CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! CollectionViewCell
        cell.movieTitleLabel.text = movies[indexPath.row].title
        cell.imageView.image = movies[indexPath.row].poster
        cell.starRating.rating = movies[indexPath.row].calculateAvgRating(ratingList: ratingList)
        cell.starRating.settings.updateOnTouch = false//set the star untouchable
        return cell
    }
}

