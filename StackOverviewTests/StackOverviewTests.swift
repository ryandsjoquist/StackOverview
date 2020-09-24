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
    
    func testParser() throws {
        // Testing using a mocked item as response to ensure A: that my struct is codable,
        // and B: that I can convert it into a local object.
        let decoder = JSONDecoder()
        var completed = false
        if let item = try? decoder.decode(DataStackOverflowItem.self,
                                          from: DataServices.readLocalFile(forName: "test") ?? Data()) {
            XCTAssertEqual(item.owner?.user_id, 1)
            XCTAssertEqual(item.answer_id, 5678)
            completed = true
        }
        XCTAssertTrue(completed)
    }

    func testURLSession() throws {
        let exp = expectation(description: "Loading answers")
        var items: [DataStackOverflowItem] = []
        
        DataServices.loadStackOFAnswers(requestType: StackOverflowRequestType.comments) { retrievedItems in
            items = retrievedItems
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)

            // our expectation has been fulfilled, so we can check the result is correct
        XCTAssertEqual(items.count, 30, "We should have loaded exactly 30 answers from request.")
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
