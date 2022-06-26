//
//  TransactionModel.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import Foundation

class TransactionModelItem: ObservableObject {
    @Published var transactions: [TransactionModel]
    @Published var forceUpdateModel: Bool = false
    
    init(transactions: [TransactionModel]) {
        self.transactions = transactions
    }
    
    func getTotalSpent(for category: TransactionModel.Category, ignorePinned: Bool = false) -> Double {
        let selectedTransactions = TransactionModel.filter(transactions: transactions, selectedCategory: category)
        
        guard ignorePinned else {
            let pinned = selectedTransactions.filter{ $0.isPinned }
            let amount = pinned.map{ $0.amount }.reduce(0, +)
            return amount
        }
        
        let amount = selectedTransactions.map{ $0.amount }.reduce(0, +)
        return amount
    }
}

// MARK: - TransactionModel

class TransactionModel: ObservableObject {
    enum Category: String, CaseIterable {
        case all
        case food
        case health
        case entertainment
        case shopping
        case travel
        
        static var defaultCase: Category {
            return .all
        }
        
        static var allCasesExceptAllCase: [Category] {
            return Category.allCases.filter{ $0 != .all }
        }
    }
    
    enum Provider: String {
        case amazon
        case americanAirlines
        case burgerKing
        case cvs
        case exxonmobil
        case jCrew
        case starbucks
        case timeWarner
        case traderJoes
        case uber
        case wawa
        case wendys
    }
    
    let id: Int
    let name: String
    let category: Category
    let amount: Double
    let date: Date
    let accountName: String
    let provider: Provider?
    @Published var isPinned: Bool
    
    init(id: Int, name: String, category: Category, amount: Double, date: Date, accountName: String, provider: Provider? = nil) {
        self.id = id
        self.name = name
        self.category = category
        self.amount = amount
        self.date = date
        self.accountName = accountName
        self.provider = provider
        self.isPinned = false
    }
}

extension TransactionModel: Identifiable {}

// MARK: - Category

extension TransactionModel.Category: Identifiable {
    var id: String {
        rawValue
    }
}

extension TransactionModel.Category {
    static subscript(index: Int) -> Self? {
        guard
            index >= 0 &&
            index < TransactionModel.Category.allCases.count
        else {
            return nil
        }
        
        return TransactionModel.Category.allCases[index]
    }
}
