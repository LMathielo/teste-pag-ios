//
//  GenreViewCell.swift
//  teste-pag-ios
//
//  Created by Lucas Mathielo Gomes on 2019-08-21.
//  Copyright © 2019 Lucas Mathielo Gomes. All rights reserved.
//

import UIKit

class GenreViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    var genreTitle: String!
    var genreId: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("AWAKEN -> \(genreTitle)")
    }
    
    func configure(with genre: Genre) {
        titleLabel.text = genre.name
        genreTitle = genre.name
        genreId = genre.id
    }
}
