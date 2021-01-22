//
//  HomePresenter.swift
//

import UIKit

class HomePresenter: HomeViewToPresenterProtocol {
    private var _view: HomePresenterToViewProtocol?
    private var _interactor: HomePresenterToInteractorProtocol?
    private var _router: HomePresenterToRouterProtocol?
    var currentPage: Int?
    private var totalPage:Int = 0
    private var tempSearchKeyword = ""
    var currentKeyWord: String? {
        didSet {
            if(currentKeyWord?.count != 0) {
                if(tempSearchKeyword != (currentKeyWord ?? "")) {
                    movieList = []
                    currentPage = 1
                }
                fetchMovie()
            }else {
                tempSearchKeyword = currentKeyWord ?? ""
                movieList = []
            }
        }
    }
    var movieList: [Movie]? {
        didSet {
            _view?.refreshTableView()
        }
    }

    
    //MARK:- Initialization
    init(router: HomePresenterToRouterProtocol, view: HomePresenterToViewProtocol, interactor: HomePresenterToInteractorProtocol) {
        _view = view
        _router = router
        _interactor = interactor
    }
    
    //MARK:- Called when view will appear called from controller
    func viewDidLoad() {
        fetchMovie()
    }
    
    private func fetchMovie() {
        _interactor?.getMovieData(with: currentKeyWord ?? "", for: currentPage ?? 1)
    }
    
    //MARK:- Route to Detail Screen
    func didClickMovies(for index: Int) {
        _router?.pushToDetailScreen()
    }
    
    //MARK:- Reach bottom of the scroll
    func reachedBottomOftheScroll() {
        currentPage = (currentPage ?? 0) + 1
        fetchMovie()
    }
}

//MARK:- Interactor to presenter Protocols
extension HomePresenter : HomeInteractorToPresenterProtocol {
    func movieResultData(data: MovieList) {
        movieList?.append(contentsOf: data.result)
        if(data.result.count == 0) {
            totalPage = 1
            _router?.showAlertPopup(with: "No result found", title: AlertConstants.alertTitle, successButtonTitle: AlertConstants.alertTitle)
        }else {
            totalPage = Int(data.totalResults) ?? 1
        }
    }
    
    func movieFetchFailedWithError(errorString: String) {
        _router?.showAlertPopup(with: errorString, title: AlertConstants.alertTitle, successButtonTitle: AlertConstants.alertTitle)
    }
}
