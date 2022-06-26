//
//  TransactionListView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

struct TransactionListView: View {
    let transactions: [TransactionModel] = ModelData.sampleTransactions
    let categories: [TransactionModel.Category] = TransactionModel.Category.allCases
    @State var selectedCategory: TransactionModel.Category = .defaultCase
    @State var selectedTotal: Double = setSelectedTotal()
    
    static func setSelectedTotal() -> Double {
        let transactions = ModelData.sampleTransactions
        let amounts = transactions.map{ $0.amount }
        let total = amounts.reduce(0, +)
        return total
    }
    
    func updateSelectedTotal() {
        let filteredTransactions = TransactionModel.filter(transactions: transactions, selectedCategory: selectedCategory)
        let amounts = filteredTransactions.map{ $0.amount }
        let total = amounts.reduce(0, +)
        selectedTotal = total
    }
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(categories) { category in
                        CategoryButtonView(name: category.rawValue, colour: category.color, action: {
                            selectedCategory = category
                            updateSelectedTotal()
                        })
                    }
                }.padding()
            }.background(Color.accentColor.opacity(0.8))
            
            List {
                ForEach(TransactionModel.filter(transactions: transactions, selectedCategory: selectedCategory)) { transaction in
                    TransactionView(transaction: transaction)
                }
            }
            .animation(.easeIn)
            .listStyle(PlainListStyle())
            
            SummaryView(selectedCategory: $selectedCategory, total: $selectedTotal)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Transactions")
    }
}

#if DEBUG
struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
    }
}
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
                
                let readableTotal = String(format: "$%.02f", total)
                Text(readableTotal)
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
