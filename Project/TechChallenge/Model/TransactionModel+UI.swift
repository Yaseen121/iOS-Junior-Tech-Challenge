//
//  TransactionModel+UI.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 12/8/21.
//

import SwiftUI

extension TransactionModel {
    var image: Image {
        guard
            let provider = provider,
            let uiImage = UIImage(named: provider.rawValue)
        else {
            return Image(systemName: "questionmark.circle.fill")
        }
        
        return Image(uiImage: uiImage)
    }
    
    static func filter(transactions: [TransactionModel], selectedCategory: TransactionModel.Category) -> [TransactionModel] {
        if selectedCategory == .all {
            return  transactions
        } else {
            return transactions.filter{ $0.category == selectedCategory }
        }
    }
}

extension TransactionModel.Category {
    var color: Color {
        switch self {
        case .all:
            return .black
        case .food:
            return .green
        case .health:
            return .pink
        case .entertainment:
            return .orange
        case .shopping:
            return .blue
        case .travel:
            return .purple
        }
    }
}
