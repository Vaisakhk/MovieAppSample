//
//  DetailViewController.swift
//  MovieApp
//
//  Created by User on 1/22/21.
//

import UIKit

class DetailViewController: UIViewController {
    var presenter:DetailViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

//MARK:- Detail Presenter To view Protocol
extension DetailViewController : DetailPresenterToViewProtocol {
    
    func refreshMovieData() {
        presenter?.movieDetail
    }

}
