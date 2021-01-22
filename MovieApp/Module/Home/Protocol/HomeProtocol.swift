//
//  HomeProtocol.swift
//

import UIKit

protocol HomeViewToPresenterProtocol: BasePresenterProtocal{
    func didClickMovies(for index:Int)
    func reachedBottomOftheScroll()
    var movieList: [Movie]? { get }
    var currentPage: Int? { get }
    var currentKeyWord: String? { get set }
}

protocol HomePresenterToViewProtocol: BaseViewProtocol{
    func refreshTableView()
    func refreshTableViewCell(at index:IndexPath)
}

protocol HomePresenterToRouterProtocol: RouterProtocal {
    func pushToDetailScreen(movieID:String)
//    func showLoaningPopup(successBlock:@escaping (_ isSuccess:Bool,_ enteredText:String) -> Void)
}

protocol HomePresenterToInteractorProtocol: BaseInteractorProtocol {
    var presenter:HomeInteractorToPresenterProtocol? {get set}
    func getMovieData(with searchText:String, for page:Int)
//    func insertBorrowerData(name:String,selectedTool:Tools, indexValue:Int)
}

protocol HomeInteractorToPresenterProtocol: BaseInteractorToPresenterProtocol {
    func movieResultData(data:MovieList)
//    func borrowCompletedWithSuccess(data:Tools,index:Int)
    func movieFetchFailedWithError(errorString:String)
}
