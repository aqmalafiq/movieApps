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
    @IBOutlet weak var searchController: UISearchBar!
    
    var movies: [Movie] = []
    var filteredMovies: [Movie] = []
    var ratingList: [Rating] = []
    var searchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationController?.navigationBar.barTintColor = UIColor.darkGray
        let defaults: UserDefaults = UserDefaults.standard
        //assume user has logged in
        if defaults.string(forKey: "loggedInUserID") == nil {
            let loggedInUserID: String = "ECD600DF-EDF1-5B49-FF8D-458625C56000"
            defaults.set(loggedInUserID, forKey: "loggedInUserID")
            defaults.synchronize()
        }
        
        
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
        movieDetailVC.delegate = self
        let movieIndex: Int = (sender as? Int)!
        movieDetailVC.movieSelected = movies[movieIndex]
        movieDetailVC.selectedMovieRating = movies[movieIndex].calculateAvgRating(ratingList: ratingList)
        movieDetailVC.ratingList = ratingList
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
        if searchActive {
            return filteredMovies.count
        } else {
            return movies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //code
        let cell : CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! CollectionViewCell
        if searchActive {
            cell.movieTitleLabel.text = filteredMovies[indexPath.row].title
            cell.imageView.image = filteredMovies[indexPath.row].poster
            cell.starRating.rating = filteredMovies[indexPath.row].calculateAvgRating(ratingList: ratingList)
        } else {
            cell.movieTitleLabel.text = movies[indexPath.row].title
            cell.imageView.image = movies[indexPath.row].poster
            cell.starRating.rating = movies[indexPath.row].calculateAvgRating(ratingList: ratingList)
        }
        cell.movieTitleLabel.adjustsFontSizeToFitWidth = true
        cell.starRating.settings.updateOnTouch = false//set the star untouchable
        return cell
    }
}
extension MovieListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
         searchActive = true
         searchController.showsCancelButton = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        self.searchController.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.searchController.resignFirstResponder()
        searchController.showsCancelButton = false
        searchController.text = ""
        self.collectionView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         searchController.showsCancelButton = true
        filteredMovies.removeAll()
            for movieItem in movies {
                if (movieItem.title.lowercased()).range(of: searchText.lowercased()) != nil  {
                    filteredMovies.append(movieItem)
                }
            }
        if(filteredMovies.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.collectionView.reloadData()
        
    }
}
extension MovieListViewController: addedReviewDelegate {
    func didAddReview(vc: MovieDetailViewController) {
        self.dismiss(animated: true, completion: nil)
        sleep(3)
        refreshMovieList()
    }
}


