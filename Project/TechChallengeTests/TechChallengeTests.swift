//
//  TechChallengeTests.swift
//  TechChallengeTests
//
//  Created by Adrian Tineo Cabello on 30/7/21.
//

import XCTest
@testable import TechChallenge

class TechChallengeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testFilterCategory() throws {
        let transcations = ModelData.sampleTransactions
        XCTAssertEqual(transcations.count, 13)
        
        let foodTranscations = TransactionModel.filter(transactions: transcations, selectedCategory: .food)
        XCTAssertEqual(foodTranscations.count, 5)
        
        let healthTranscations = TransactionModel.filter(transactions: transcations, selectedCategory: .health)
        XCTAssertEqual(healthTranscations.count, 1)
        
        let entertainmentTranscations = TransactionModel.filter(transactions: transcations, selectedCategory: .entertainment)
        XCTAssertEqual(entertainmentTranscations.count, 1)
        
        let shoppingTranscations = TransactionModel.filter(transactions: transcations, selectedCategory: .shopping)
        XCTAssertEqual(shoppingTranscations.count, 3)
        
        let travelTranscations = TransactionModel.filter(transactions: transcations, selectedCategory: .travel)
        XCTAssertEqual(travelTranscations.count, 3)
    }
    
    static func getTotalSpent(in transcations: [TransactionModel]) -> Double {
        let amounts = transcations.map{ $0.amount }
        let total = amounts.reduce(0, +)
        return total
    }
    
    func testSumOfFilteredCategory() throws {
        let transcations = ModelData.sampleTransactions
        let transactionsItem = TransactionModelItem(transactions: transcations)
        let totalAmount = transactionsItem.getTotalSpent(for: .all, ignorePinned: true)
        XCTAssertEqual(totalAmount, 472.08, accuracy: 0.000000001)
        
        let foodTotalAmount = transactionsItem.getTotalSpent(for: .food, ignorePinned: true)
        XCTAssertEqual(foodTotalAmount, 74.28, accuracy: 0.000000001)
        
        let healthTotalAmount = transactionsItem.getTotalSpent(for: .health, ignorePinned: true)
        XCTAssertEqual(healthTotalAmount, 21.53, accuracy: 0.000000001)
        
        let entertainmentTotalAmount = transactionsItem.getTotalSpent(for: .entertainment, ignorePinned: true)
        XCTAssertEqual(entertainmentTotalAmount, 82.99, accuracy: 0.000000001)
        
        let shoppingTotalAmount = transactionsItem.getTotalSpent(for: .shopping, ignorePinned: true)
        XCTAssertEqual(shoppingTotalAmount, 78, accuracy: 0.000000001)
        
        let travelTotalAmount = transactionsItem.getTotalSpent(for: .travel, ignorePinned: true)
        XCTAssertEqual(travelTotalAmount, 215.28, accuracy: 0.000000001)
    }
}
