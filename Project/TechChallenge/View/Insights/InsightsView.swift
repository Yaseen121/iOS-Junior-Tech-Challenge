//
//  InsightsView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 29/7/21.
//

import SwiftUI

struct InsightsView: View {
    @ObservedObject var transactionItems: TransactionModelItem
    
    var body: some View {
        List {
            ForEach(TransactionModel.Category.allCasesExceptAllCase) { category in
                InsightsViewListCell(category: category, transactionItems: transactionItems)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Insights")
    }
}

#if DEBUG
struct InsightsView_Previews: PreviewProvider {
    static let transactionsItem: TransactionModelItem = TransactionModelItem(transactions: ModelData.sampleTransactions)
    
    static var previews: some View {
        InsightsView(transactionItems: transactionsItem)
            .previewLayout(.sizeThatFits)
    }
}
#endif

struct InsightsViewListCell: View {
    let category: TransactionModel.Category
    @ObservedObject var transactionItems: TransactionModelItem
    
    var body: some View {
        HStack {
            Text(category.rawValue)
                .font(.headline)
                .foregroundColor(category.color)
            Spacer()
            Text(transactionItems.getTotalSpent(for: category).readableSum)
                .bold()
                .secondary()
        }
    }
}
