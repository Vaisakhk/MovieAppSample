//
//  DetailsInteractor.swift
//  MovieApp
//
//  Created by User on 1/22/21.
//

import UIKit

class DetailsInteractor: DetailPresenterToInteractorProtocol {

    var defaultSession:DHURLSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    var presenter: DetailInteractorToPresenterProtocol?
    
    //MARK:- Get Movie Details
    
    /* Get Moview Details based on movieID name,
     * Parameters :
            movieID: Movie IMDB iD
     */
    func getDetailsData(for movieID: String) {
        dataTask?.cancel()
        let queryString = String(format: "%@apikey=%@&i=%@",MOVIEAPI.BASEURL,MOVIEAPI.MOVIEKEY,movieID)
        print(queryString)
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
                    
                if let data = data, let moviesData = try? JSONDecoder().decode(MovieDetail.self, from: data)
                        {
                        DispatchQueue.main.async {
                            self?.presenter?.detailResultData(data: moviesData)
                        }
                        
                    }
            }
            dataTask?.resume()
    }
    
}
