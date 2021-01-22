//
//  DetailsInteractorTests.swift
//  MovieAppTests
//
//  Created by User on 1/22/21.
//

import XCTest
@testable import MovieApp
class DetailsInteractorTests: XCTestCase {

    var mockPresenter:FakeDetailInteractionToPresenter?
    var sut :DetailsInteractor?
    
    override func setUpWithError() throws {
        mockPresenter = FakeDetailInteractionToPresenter()
        sut = DetailsInteractor()
        sut?.presenter = mockPresenter
        
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "MovieDeatilSample", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        
        let url =
            URL(string: "http://www.omdbapi.com/?apikey=b9bd48a6&i=tt4154664")
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
    
    func testGetDetailsData() {
        sut?.getDetailsData(for: "tt4154664")
    }
    
    //MARK:- Movie Api test
     func testGetDetailsDataAsync() {
         let promise = expectation(description: "Status code: 200")
         let dataTask =  sut?.defaultSession.dataTask(with:  URL(string: "http://www.omdbapi.com/?apikey=b9bd48a6&i=tt4154664")!, completionHandler: { (data, response, error) in
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
class FakeDetailInteractionToPresenter: DetailInteractorToPresenterProtocol {
    var fakeMovieDetail:MovieDetail?
    var fakeErrorString:String?
    func movieFetchFailedWithError(errorString: String) {
        fakeErrorString = errorString
    }
    
    func detailResultData(data: MovieDetail) {
        fakeMovieDetail = data
        XCTAssertNotNil(data,"Movie Result is Nil")
        XCTAssertEqual(data.title, "Captain Marvel", "expected title is different")
        XCTAssertEqual(data.runtime, "123 min", "expected movie duration is different")
    }
}
