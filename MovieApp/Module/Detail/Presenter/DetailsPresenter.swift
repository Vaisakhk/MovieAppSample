//
//  DetailsPresenter.swift
//  MovieApp
//
//  Created by User on 1/22/21.
//

import UIKit

class DetailsPresenter: DetailViewToPresenterProtocol {
    private var _view: DetailPresenterToViewProtocol?
    private var _interactor: DetailPresenterToInteractorProtocol?
    private var _router: DetailPresenterToRouterProtocol?
    
    var movieDetail: MovieDetail? {
        didSet {
            _view?.refreshMovieData()
        }
    }
    
    var imdbId: String? {
        didSet {
          
        }
    }
    
    func fetchMovieDetails() {
        
    }
    
    //MARK:- Initialization
    init(router: DetailPresenterToRouterProtocol, view: DetailPresenterToViewProtocol, interactor: DetailPresenterToInteractorProtocol,imdbIdValue:String) {
        _view = view
        _router = router
        _interactor = interactor
        imdbId = imdbIdValue
    }
    
    func viewDidLoad() {
        guard let imbdIDVAlue = imdbId else {
            return
        }
        _interactor?.getDetailsData(for: imbdIDVAlue)
    }
}

//MARK:- Detail Interactor To Presenter Protocol
extension DetailsPresenter : DetailInteractorToPresenterProtocol {
    func detailResultData(data: MovieDetail) {
        movieDetail = data
    }
    
    func movieFetchFailedWithError(errorString:String) {
        movieDetail = nil
        _view?.refreshMovieData()
        _router?.showAlertPopup(with: errorString, title: AlertConstants.alertTitle, successButtonTitle: AlertConstants.alertTitle)
    }
}
