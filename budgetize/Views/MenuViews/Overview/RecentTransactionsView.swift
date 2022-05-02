//
//  RecentTransactionsView.swift
//  budgetize
//
//  Created by Eugene Ned on 30.04.2022.
//

import SwiftUI

struct RecentTransactionsView: View {
    @ObservedObject var viewModel = TransactionsViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("Recent Transactions")
                    .bold()
                
                Spacer()
                
                NavigationLink {
                    TransactionsView()
                } label: {
                    HStack(spacing: 4) {
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color(.systemIndigo))
                }
            }
            .padding(.top)
            
            ForEach(viewModel.transactions.sorted(by: {
                $0.date.compare($1.date) == .orderedDescending
            }).prefix(5), id: \.self) { transaction in
                
                TransactionRowView(category: transaction.category, date: transaction.date, amount: transaction.amount)
                Divider()
                    .opacity(viewModel.transactions.prefix(5).last == transaction ? 0 : 1)
                    .padding(.horizontal)
                
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color(.systemIndigo).opacity(0.3), radius: 15, x: 0, y: 5)
    }
}

struct RecentTransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RecentTransactionsView()
            RecentTransactionsView()
                .preferredColorScheme(.dark)
        }
    }
}
