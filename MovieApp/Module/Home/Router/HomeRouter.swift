//
//  HomeRouter.swift
//

import UIKit

final class HomeRouter: BaseRouter {
    init() {
        let view = UIStoryboard(name:"Main",bundle: Bundle.main).instantiateViewController(withIdentifier: "viewController") as! ViewController
        super.init(viewController: view)
        let interactor: HomePresenterToInteractorProtocol = HomeInteractor()
        let router:HomePresenterToRouterProtocol = self
        let presenter: HomeViewToPresenterProtocol & HomeInteractorToPresenterProtocol = HomePresenter(router: router, view: view, interactor: interactor)
      
        view.presenter = presenter
        interactor.presenter = presenter
    }
    
    //MARK:- Navigate to Friends list
    private func navigateToFriendsDetail(idString:String) {
        let controller = DetailsRouter(idString)
        navigationController?.pushRouter(controller, animated: true)
       // viewController.presentRouter(controller, presentationStyle: .fullScreen)
    }
}

//MARK:- Home Presenter To Router Protocol
extension HomeRouter: HomePresenterToRouterProtocol {
    func pushToDetailScreen(movieID:String) {
        navigateToFriendsDetail(idString:movieID)
    }
    
//    func showLoaningPopup(successBlock:@escaping (_ isSuccess:Bool,_ enteredText:String) -> Void) {
//        let alert = UIAlertController(title: AlertConstants.alertTitle , message: AlertConstants.enterName , preferredStyle: .alert)
//        let ok  = UIAlertAction(title: AlertConstants.saveButtonTitle, style: .default) { (UIAlertAction) in
//            let textField = alert.textFields![0] as UITextField
//            successBlock(true,textField.text ?? "")
//        }
//        alert.addAction(ok)
//        alert.addTextField { (textField : UITextField!) -> Void in
//            textField.placeholder = AlertConstants.enterNamePlaceHolder
//            textField.borderStyle = .none
//        }
//        let cancel  = UIAlertAction(title: AlertConstants.cancelButtonTitle, style: .default) { (UIAlertAction) in
//            successBlock(false,"")
//        }
//        alert.addAction(cancel)
//        viewController.present(alert, animated: true, completion: nil);
//    }
}
