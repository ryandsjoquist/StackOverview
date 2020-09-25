//
//  StackOverviewTests.swift
//  StackOverviewTests
//
//  Created by Bonhoffer on 9/22/20.
//

import XCTest
@testable import StackOverview

class StackOverviewTests: XCTestCase {
    var items :[Any] = []
    func testParser() throws {
        // Testing using a mocked item as response to ensure A: that my struct is codable,
        // and B: that I can convert it into a local object.
        let decoder = JSONDecoder()
        var completed = false
        if let item = try? decoder.decode(DataStackOverflowItem.self,
                                          from: Utilities.readLocalFile(forName: "test") ?? Data()) {
            XCTAssertEqual(item.owner?.user_id, 1)
            XCTAssertEqual(item.question_id, 11227809)
            completed = true
        }
        XCTAssertTrue(completed)
    }

    func testURLSession() throws {
        let exp = expectation(description: "Loading answers")
        
        NetworkServices.loadStackOFAnswers(requestResultType: .questions,
                                           requestResultSite: .stackoverflow) { [weak self] retrievedItems in
            self?.items = retrievedItems
            exp.fulfill()
        }
        waitForExpectations(timeout: 15)

        XCTAssertEqual(items.count, 30, "We should have loaded exactly 30 answers from request.")

    }

    func testConversionSuccess() throws {
        let exp = expectation(description: "Loading answers")
        NetworkServices.loadStackOFAnswers(requestResultType: .questions,
                                           requestResultSite: .stackoverflow) { [weak self] retrievedItems in
                DataServices.convertDataToLocalItems(retrievedItems)
                XCTAssertTrue(DataServices.questions.count > 0)
                exp.fulfill()
            }

        waitForExpectations(timeout: 15)
        
    }
    

}
