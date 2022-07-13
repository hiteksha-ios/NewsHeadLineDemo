//
//  NewsHeadlineAPITest.swift
//  NewsHeadlineDemoTests
//
//  Created by Admin on 7/13/22.
//

import XCTest
import Alamofire
@testable import NewsHeadlineDemo

class NewsHeadlineAPITest: XCTestCase {

    func test_NewsHeadlineAPI_Response_Returns_ResponseFailure() {
        
        var newsDataRequest: DataRequest!
        let expectation = self.expectation(description: "Response_Returns_ResponseFailure")
        newsDataRequest = APIManager.shared.requestGetJSON(url: eAPIURL.fetchTopNewsHeadlines, parameters: [:], isShowIndicator: false, completionHandler: { (result) in
            XCTAssertNotNil(result)
            switch result {
            case .success(let dicData):
                XCTAssertNotNil(dicData)
                expectation.fulfill()
                
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Data not in correct format!")
                expectation.fulfill()
            }
        })
        self.waitForExpectations(timeout: 5)
    }
}
