//
//  HomeInteractor.swift
//

import Foundation
import UIKit

class HomeInteractor: HomePresenterToInteractorProtocol {
    var presenter: HomeInteractorToPresenterProtocol?
    var defaultSession:DHURLSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    
    //MARK:- Get All Movies
    /* To Get All the Movie list based on search Keyword
            result is passing to Presenter
            If no movies inserted empty Array will pass to Presenter
     *
     */
    
    func getMovieData(with searchText: String, for page: Int) {
        searchMoview(searchTerm: searchText, index: "\(page)")
    }
    
    //MARK:- Search weather result From Api
    private func searchMoview(searchTerm :String,index :String ) {
        dataTask?.cancel()
        //http://www.omdbapi.com/?apikey=b9bd48a6&s=abcd&type=movie&page=2
        let queryString = String(format: "%@apikey=%@&s=%@&type=movie&page=%@",MOVIEAPI.BASEURL,MOVIEAPI.MOVIEKEY ,searchTerm, index)
        guard let url = URL(string: queryString) else {
            return
        }
            dataTask =
                defaultSession.dataTask(with: url) { [weak self] data, response, error in
                    defer {
                        self?.dataTask = nil
                    }
                    
                    if let error = error {
                        DispatchQueue.main.async {
                            self?.presenter?.movieFetchFailedWithError(errorString: "Error with fetching films: \(error.localizedDescription)")
                        }
                        return
                    }
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200...299).contains(httpResponse.statusCode) else {
                        DispatchQueue.main.async {
                            self?.presenter?.movieFetchFailedWithError(errorString: "Error with the response, unexpected result. \n response: \(String(describing: response))\n error : \(String(describing: error))")
                        }
                        return
                    }
                    
                if let data = data, let moviesData = try? JSONDecoder().decode(MovieList.self, from: data)
                        {
                        DispatchQueue.main.async {
                            self?.presenter?.movieResultData(data: moviesData)
                        }
                        
                    }
            }
            dataTask?.resume()
    }
}
