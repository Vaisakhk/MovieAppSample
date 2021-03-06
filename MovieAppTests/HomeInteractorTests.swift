//
//  HomeInteractorTests.swift
//  MovieAppTests
//
//  Created by User on 1/22/21.
//

import XCTest
@testable import MovieApp

class HomeInteractorTests: XCTestCase {
    var mockPresenter:FakeHomeInteractionToPresenter?
    var sut :HomeInteractor?
    
    
    override func setUpWithError() throws {
        mockPresenter = FakeHomeInteractionToPresenter()
        sut = HomeInteractor()
        sut?.presenter = mockPresenter
        
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "MovieSample", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        
        let url =
            URL(string: "http://www.omdbapi.com/?apikey=b9bd48a6&s=marvel&type=movie&page=1")
        let urlResponse = HTTPURLResponse(
            url: url!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil)
        
        let sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)
        sut?.defaultSession = sessionMock
    }

    override func tearDownWithError() throws {
        mockPresenter = nil
        sut = nil
    }
    
    func testGetMovieData() {
        sut?.getMovieData(with: "Marvel", for: 1)
        XCTAssertNil( mockPresenter?.fakeErrorString,"Error is Nil")
    }
    
    //MARK:- Movie Api test
     func testGetMovieDataAsync() {
         let promise = expectation(description: "Status code: 200")
         let dataTask =  sut?.defaultSession.dataTask(with:  URL(string: "http://www.omdbapi.com/?apikey=b9bd48a6&s=marvel&type=movie&page=1")!, completionHandler: { (data, response, error) in
             if let error = error {
               print(error.localizedDescription)
             } else if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                promise.fulfill()
             }
         })
         dataTask?.resume()
         wait(for: [promise], timeout: 5)
     }

}


//MARK:- Mock up Home interactor to presenter protocol
class FakeHomeInteractionToPresenter: HomeInteractorToPresenterProtocol {
    var fakeErrorString:String?
    var fakeMovieResult:MovieList?
    func movieResultData(data: MovieList) {
        fakeMovieResult = data
        XCTAssertNotNil(data,"Movie Result is Nil")
        XCTAssertEqual(data.totalResults, "11", "Total results not equat")
    }
    
    func movieFetchFailedWithError(errorString: String) {
        fakeErrorString = errorString
    }
}
