//
//  TransactionListView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

struct TransactionListView: View {
    @ObservedObject var transactionItems: TransactionModelItem
    @Binding var transactions: [TransactionModel]
    let categories: [TransactionModel.Category] = TransactionModel.Category.allCases
    @State var selectedCategory: TransactionModel.Category = .defaultCase
    @State var pinnedTotal: Double = setPinnedTotal()
    
    static func setPinnedTotal() -> Double {
        let transactions = TransactionModel.filter(transactions: ModelData.sampleTransactions, selectedCategory: .defaultCase)
        let pinned = transactions.filter{ $0.isPinned }
        let amounts = pinned.map{ $0.amount }
        let total = amounts.reduce(0, +)
        return total
    }
    
    func updatePinnedTotal() {
        let filteredTransactions = TransactionModel.filter(transactions: transactions, selectedCategory: selectedCategory)
        let pinned = filteredTransactions.filter{ $0.isPinned }
        let amounts = pinned.map{ $0.amount }
        let total = amounts.reduce(0, +)
        transactionItems.forceUpdateModel.toggle()
        pinnedTotal = total
    }
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(categories) { category in
                        CategoryButtonView(name: category.rawValue, colour: category.color, action: {
                            selectedCategory = category
                            updatePinnedTotal()
                        })
                    }
                }.padding()
            }.background(Color.accentColor.opacity(0.8))
            
            List {
                if selectedCategory == .all {
                    ForEach($transactions) { transaction in
                        TransactionView(transaction: transaction) {
                            updatePinnedTotal()
                        }
                    }
                } else {
                    ForEach($transactions.filter{ $0.wrappedValue.category == selectedCategory }) { transaction in
                        TransactionView(transaction: transaction) {
                            updatePinnedTotal()
                        }
                    }
                }
            }
            .animation(.easeIn)
            .listStyle(PlainListStyle())
            
            SummaryView(selectedCategory: $selectedCategory, total: $pinnedTotal)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Transactions")
    }
}

#if DEBUG
//struct TransactionListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionListView()
//    }
//}
#endif

struct CategoryButtonView: View {
    let name: String
    let colour: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(name)
                .font(.system(.title2))
                .bold()
                .foregroundColor(.white)
                .padding()
        }).background(colour)
            .clipShape(Capsule())
    }
}

struct SummaryView: View {
    @Binding var selectedCategory: TransactionModel.Category
    @Binding var total: Double
    
    var body: some View {
        VStack {
            Text(selectedCategory.rawValue)
                .font(.system(.headline))
                .foregroundColor(selectedCategory.color)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            HStack {
                Text("Total spent:")
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(total.readableSum)
                    .bold()
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.accentColor, lineWidth: 2)
        ).padding(8)
    }
}
