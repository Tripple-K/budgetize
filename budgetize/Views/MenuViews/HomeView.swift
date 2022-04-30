//
//  HomeView.swift
//  budgetize
//
//  Created by Eugene Ned on 24.04.2022.
//

import SwiftUI


struct HomeView: View {
    @State var type: TransactionType = .income
    @ObservedObject var viewModel = TransactionsViewModel()

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.3)
                .foregroundColor(.gray)
            ForEach(viewModel.getActiveWedges(), id: \.self) { wedge in
                Circle()
                    .trim(from: wedge.startAngle, to: wedge.endAngle)
                    .stroke(lineWidth: 20)
                    .foregroundColor(wedge.color)
            }
        }
        .frame(width: 150, height: 150)
        .onAppear {
            viewModel.getTransactionsByType(type)
        }
    }
    
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
