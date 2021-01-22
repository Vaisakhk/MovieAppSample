//
//  DetailsProtocol.swift
//  MovieApp
//
//  Created by User on 1/22/21.
//
import UIKit

protocol DetailViewToPresenterProtocol: BasePresenterProtocal{
    var imdbId: String? {get}
    var movieDetail: MovieDetail? { get }
}

protocol DetailPresenterToViewProtocol: BaseViewProtocol{
    func refreshMovieData()
}

protocol DetailPresenterToRouterProtocol: RouterProtocal {
    func popDetailViewController()
}

protocol DetailPresenterToInteractorProtocol: BaseInteractorProtocol {
    var presenter:DetailInteractorToPresenterProtocol? {get set}
    func getDetailsData(for movieID:String)

}

protocol DetailInteractorToPresenterProtocol: BaseInteractorToPresenterProtocol {
    func detailResultData(data:MovieDetail)
    func movieFetchFailedWithError(errorString:String)
}
