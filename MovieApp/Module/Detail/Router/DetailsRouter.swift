//
//  DetailsRouter.swift
//  MovieApp
//
//  Created by User on 1/22/21.
//

import UIKit

class DetailsRouter: BaseRouter {
    init(_ movieID:String) {
        let view = DetailViewController(nibName: "DetailViewController", bundle: nil)
        super.init(viewController: view)
        
        let interactor: DetailPresenterToInteractorProtocol = DetailsInteractor()
        let router:DetailPresenterToRouterProtocol = self//HomeRouter(viewController: view)
        let presenter: DetailViewToPresenterProtocol & DetailInteractorToPresenterProtocol = DetailsPresenter(router: router, view: view, interactor: interactor,imdbIdValue: movieID)
        view.presenter = presenter
        interactor.presenter = presenter
    }
}

extension DetailsRouter: DetailPresenterToRouterProtocol {
    func popDetailViewController() {
        navigationController?.popRouter()
    }
}
