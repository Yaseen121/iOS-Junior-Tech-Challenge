//
//  TransactionView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

struct TransactionView: View {
    @Binding var transaction: TransactionModel
    let pressedAction: () -> Void
    
    var body: some View {
        Button(action: {
            transaction.isPinned.toggle()
            pressedAction()
        }, label: {
            VStack {
                HStack {
                    Text(transaction.category.rawValue)
                        .font(.headline)
                        .foregroundColor(transaction.category.color)
                    Spacer()
                    if transaction.isPinned {
                        Image(systemName: "pin.fill")
                    } else {
                        Image(systemName: "pin.slash.fill")
                    }
                }
                
                if transaction.isPinned {
                    HStack {
                        transaction.image
                            .resizable()
                            .frame(
                                width: 60.0,
                                height: 60.0,
                                alignment: .top
                            )
                        
                        VStack(alignment: .leading) {
                            Text(transaction.name)
                                .secondary()
                            Text(transaction.accountName)
                                .tertiary()
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("$\(transaction.amount.formatted())")
                                .bold()
                                .secondary()
                            Text(transaction.date.formatted)
                                .tertiary()
                        }
                    }
                }
            }
        })
        .padding(8.0)
        .background(Color.accentColor.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
    }
}

#if DEBUG
struct TransactionView_Previews: PreviewProvider {
    static let transactions: [TransactionModel] = ModelData.sampleTransactions
    
    static var previews: some View {
        VStack {
            ForEach(transactions) { transaction in
                TransactionView(transaction: .constant(transaction), pressedAction: {})
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
