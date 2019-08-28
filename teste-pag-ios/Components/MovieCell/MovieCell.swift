//
//  MovieCell.swift
//  teste-pag-ios
//
//  Created by Lucas Mathielo Gomes on 2019-08-22.
//  Copyright © 2019 Lucas Mathielo Gomes. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with movie: Movie) {
        self.movieImageView.downloaded(from: "\(image_base_api_url)\(movie.backdrop_path)") //image = UIImage.downloadImage(from: URL(string: )!)
        self.titleLabel.text = movie.title
        self.genresLabel.text = "wait" //String(movie.genre_ids)
        self.dateLabel.text = movie.release_date
        movieImageView.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        movieImageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        movieImageView.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        movieImageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 249), for: .vertical)
        setNeedsDisplay()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UIImageView {
    func downloaded(from url: URL) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
//        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            
            }.resume()
    }
    func downloaded(from link: String) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url)
    }
}
