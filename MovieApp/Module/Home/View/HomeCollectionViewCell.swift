//
//  HomeCollectionViewCell.swift
//  MovieApp
//
//  Created by User on 1/22/21.
//

import UIKit
import SDWebImage
class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var filmNameLabel: UILabel!
    @IBOutlet weak var filmImageView: UIImageView!
    
    //MARK:- UIView Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    //MARK:- Populate Movie data
    func populateMovieData(movie:Movie) {
        filmNameLabel.text = movie.title
        filmImageView.sd_setImage(with: URL(string: movie.poster), placeholderImage: UIImage(named: "placeHolder"), options: SDWebImageOptions.refreshCached) { (image, error, cache, url) in
        }
    }
}

