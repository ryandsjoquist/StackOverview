//
//  StackOverviewTests.swift
//  StackOverviewTests
//
//  Created by Bonhoffer on 9/22/20.
//

import XCTest
@testable import StackOverview

class StackOverviewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testURLSession() throws {
        let exp = expectation(description: "Loading answers")

        DataServices.loadStackOFAnswers { answers in
            print("got here")
            exp.fulfill()
            
        }
        waitForExpectations(timeout: 30)

            // our expectation has been fulfilled, so we can check the result is correct
//        XCTAssertEqual(parser.stories.count, 20, "We should have loaded exactly 20 stories.")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
