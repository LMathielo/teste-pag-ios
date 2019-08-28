//
//  DetailedMovieViewController.swift
//  teste-pag-ios
//
//  Created by Lucas Mathielo Gomes on 2019-08-24.
//  Copyright © 2019 Lucas Mathielo Gomes. All rights reserved.
//

import UIKit

class DetailedMovieViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImageView()
        configure(with: movie)
        // Do any add   itional setup after loading the view.
    }
    
    fileprivate func configure(with movie: Movie) {
        movieImageView.downloaded(from: "\(image_base_api_url)\(movie.backdrop_path)")
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview
        dateLabel.text = movie.release_date
        viewCountLabel.text = String(movie.vote_count)
    }
    
    fileprivate func configureImageView() {
//        movieImageView.layer.cornerRadius
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.movieImageView.frame
        rectShape.position = self.movieImageView.center
        rectShape.path = UIBezierPath(roundedRect: self.movieImageView.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        
        self.movieImageView.layer.backgroundColor = UIColor.green.cgColor
        //Here I'm masking the textView's layer with rectShape layer
        self.movieImageView.layer.mask = rectShape
    }
    
    
    static func instantiate(with movie: Movie) -> DetailedMovieViewController {
        let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailedMovieVC") as! DetailedMovieViewController
        newViewController.movie = movie
        return newViewController
    }

}
