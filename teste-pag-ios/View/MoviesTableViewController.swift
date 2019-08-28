//
//  MoviesTableViewController.swift
//  teste-pag-ios
//
//  Created by Lucas Mathielo Gomes on 2019-08-22.
//  Copyright © 2019 Lucas Mathielo Gomes. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {

    var movieList: [Movie]!
    var selectedGenreId: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiService.retrieveMovies(completion: { (movies) in
//            self.genreList = genreList
            print(movies)
            self.movieList = movies
            self.movieList = self.movieList.filter({ $0.genre_ids.contains(self.selectedGenreId) })
            self.tableView.reloadDataWithAutoSizingCellWorkAround()
        })

        
        self.tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        
//        registerViewCell()

        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.configure(with: movieList![indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailedMovieViewController.instantiate(with: movieList[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
