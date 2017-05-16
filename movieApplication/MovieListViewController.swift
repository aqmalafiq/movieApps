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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //this is what the storyboard do if you drag and drop the de
//        self.collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "movieCell")
//        self.collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
        refreshMovieList()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func refreshMovieList() {
        MovieLoader.sharedLoader.retrieveMovieList { (movieList: [Movie], success: Bool, error: Error?) in
            //code
            self.movies = movieList
            self.collectionView.reloadData()
            for movie in self.movies { //download pic poster
                MovieLoader.sharedLoader.downloadPicTask(posterURL: movie.posterURL, completionBlock: { (image: UIImage, success: Bool, error: Error?) in
                    //code
                    movie.poster = image
                    self.collectionView.reloadData()
                })
            }
        }
    }
}
extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //code
        debugPrint("item \(indexPath.row) was selected")
    }
    
}

extension MovieListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //code
        
        debugPrint(movies.count)
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //code
        let cell : CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! CollectionViewCell
        cell.movieTitleLabel.text = movies[indexPath.row].title
        cell.imageView.image = movies[indexPath.row].poster
        return cell
    }
}

