//
//  TransactionRecord.swift
//  budgetize
//
//  Created by Eugene Ned on 28.04.2022.
//

import SwiftUI

struct TransactionRecord: View {
    var category: CategoryType = .groceries
    var date: Date = Date()
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter.string(from: date)
    }
    
    var color: Color = Color(.systemIndigo)
    var amount: Double = 100.50
    
    
    
    var body: some View {

        HStack {
            Circle()
                .padding(.leading, 20.0)
                .frame(width: 70, height: 70)
                .foregroundColor(color)
            VStack(alignment: .leading) {
                Text(category.rawValue)
                    .font(.headline)
                Text(formattedDate)
                    .font(.footnote)
            }
            Spacer()
            VStack {
                Text(String(format: "%.2f", amount))
                    .font(.title)
                    .padding(.trailing)
                    .foregroundColor(amount > 0.0 ? .green : .red)
            }
        }
        .frame(height: 75.0)
        .foregroundColor(Color.black)
        .background(
            RoundedRectangle(cornerRadius: 15)
            
            .foregroundColor(Color.white)
        )
    }
}

struct TransactionRecord_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRecord()
            .preferredColorScheme(.dark)
    }
}
