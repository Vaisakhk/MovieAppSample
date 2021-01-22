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
    var presenter:DetailViewToPresenterProtocol?
    @IBOutlet weak var actorView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var writerView: UIView!
    @IBOutlet weak var RatingsView: UIView!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var synopsisView: UIView!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var directorView: UIView!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var runTImeLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var synopsysLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieTypeLabel: UILabel!
    @IBOutlet weak var releasedOnLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!

    //MARK:- UIView Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner ()
        presenter?.viewDidLoad()
    }
}

//MARK:- Detail Presenter To view Protocol
extension DetailViewController : DetailPresenterToViewProtocol {
    
    //MARK:- Movie Detail Api result
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
            releasedOnLabel.text = "Release on " + movieDetail.released
            synopsysLabel.text = movieDetail.plot
            directorLabel.text = movieDetail.director
            writerLabel.text = movieDetail.writer
            actorLabel.text = movieDetail.actors
        }else {
            hideSpinner()
        }
    }

    func unHideAllViews() {
        posterImageView.isHidden = false
        titleView.isHidden = false
        RatingsView.isHidden = false
        synopsisView.isHidden = false
        directorView.isHidden = false
        writerView.isHidden = false
        actorView.isHidden = false
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
