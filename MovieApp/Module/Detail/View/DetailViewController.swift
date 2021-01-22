//
//  DetailViewController.swift
//  MovieApp
//
//  Created by User on 1/22/21.
//

import UIKit
import PKHUD
import SDWebImage

class DetailViewController: UIViewController {
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var RatingsView: UIView!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var movieTypeLabel: UILabel!
    @IBOutlet weak var runTImeLabel: UILabel!
    var presenter:DetailViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner ()
        presenter?.viewDidLoad()
    }

}

//MARK:- Detail Presenter To view Protocol
extension DetailViewController : DetailPresenterToViewProtocol {
    
    func refreshMovieData() {
        hideSpinner()
        unHideAllViews()
        if let movieDetail = presenter?.movieDetail {
            movieNameLabel.text = movieDetail.title
            posterImageView.sd_setImage(with: URL(string: movieDetail.poster ), placeholderImage: UIImage(named: "placeHolder"), options: SDWebImageOptions.refreshCached) { (image, error, cache, url) in
            }
            runTImeLabel.text = movieDetail.runtime
            movieTypeLabel.text = movieDetail.genre
            ratingsLabel.text = movieDetail.imdbRating
        }else {
            hideSpinner()
        }
    }

    func unHideAllViews() {
        posterImageView.isHidden = false
        titleView.isHidden = false
        RatingsView.isHidden = false
    }
}

//MARK:- Show and Hide Spinner
extension DetailViewController {
    @objc func showSpinner() {
        DispatchQueue.main.async {
            PKHUD.sharedHUD.contentView = PKHUDProgressView()
            PKHUD.sharedHUD.show()
        }
    }

    @objc func hideSpinner() {
        DispatchQueue.main.async {
            PKHUD.sharedHUD.hide()
        }
    }
}
