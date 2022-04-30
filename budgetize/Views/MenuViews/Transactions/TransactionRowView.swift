//
//  TransactionRecord.swift
//  budgetize
//
//  Created by Eugene Ned on 28.04.2022.
//

import SwiftUI

struct TransactionRowView: View {
    var category: CategoryType = .groceries
    var date: Date = Date()
//    var formattedDate: String {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .short
//
//        return formatter.string(from: date)
//    }
    
    var color: Color = Color(.systemIndigo)
    var amount: Double = 100.50
    
    
    
    var body: some View {

//        HStack {
//            Circle()
//                .padding(.leading, 20.0)
//                .frame(width: 70, height: 70)
//                .foregroundColor(color)
//            VStack(alignment: .leading) {
//                Text(category.rawValue)
//                    .font(.headline)
//                Text(formattedDate)
//                    .font(.footnote)
//            }
//            Spacer()
//            VStack {
//                Text(String(format: "%.2f", amount))
//                    .font(.title)
//                    .padding(.trailing)
//                    .foregroundColor(amount > 0.0 ? .green : .red)
//            }
//        }
//        .frame(height: 75.0)
//        .foregroundColor(Color.black)
//        .background(
//            RoundedRectangle(cornerRadius: 15)
//
//            .foregroundColor(Color.white)
//        )
    
        HStack(spacing: 20) {
            if #available(iOS 15.0, *) {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color(.systemIndigo).opacity(0.3))
                    .frame(width: 44, height: 44)
                    .overlay {
                        Text(String(UnicodeScalar(Array(0x1F300...0x1F3F0).randomElement()!)!))
                    }
            }
            VStack(alignment: .leading, spacing: 6) {
                Text(category.rawValue)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                if #available(iOS 15.0, *) {
                    Text(date, format: .dateTime.year().month().day())
                        .font(.footnote)
                        .opacity(0.7)
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            if #available(iOS 15.0, *) {
                Text(amount, format: .currency(code: "USD"))
                    .bold()
                    .foregroundColor(amount > 0.0 ? .green : .red)
            }
        }
        .padding( 8)
    }
}

struct TransactionRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TransactionRowView()
                .preferredColorScheme(.dark)
            TransactionRowView()
        }
    }
}

