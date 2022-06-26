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
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(categories) { category in
                        CategoryButtonView(name: category.rawValue, colour: category.color, action: {
                            selectedCategory = category
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
