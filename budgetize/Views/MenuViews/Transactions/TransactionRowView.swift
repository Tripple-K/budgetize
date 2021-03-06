
import SwiftUI

struct TransactionRowView: View {
    
    @EnvironmentObject var accountsViewModel: AccountsViewModel
    @State var transaction: Transaction

    var color: Color {
        switch transaction.type {
        case .income: return .green
        case .expense: return .red
        case .transfer: return .gray
        }
    }
    
    var body: some View {
        
        HStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.systemIndigo).opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay {
                    Text(String(UnicodeScalar(Array(0x1F300...0x1F3F0).randomElement()!)!))
                }
            VStack(alignment: .leading, spacing: 3) {
                Text(transaction.category.rawValue)
                    .font(.subheadline)
                    .bold()
                
                HStack {
                    Text(accountsViewModel.accounts.first(where: { $0.id == transaction.fromAccountId })?.name ?? "")
                        .font(.footnote)
                        .opacity(0.8)
                    if transaction.type == .transfer {
                        Image(systemName: "arrow.right")
                            .opacity(0.8)
                        Text(accountsViewModel.accounts.first(where: { $0.id == transaction.toAccountId })?.name ?? "")
                            .font(.footnote)
                            .opacity(0.8)
                    }
                }
                
                Text(transaction.date, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .opacity(0.6)
            }
            Spacer()
            
            Text(transaction.amount, format: .currency(code: "\(transaction.currency.rawValue)"))
                .bold()
                .foregroundColor(color)
        }
        .padding(8)
    }
}

//struct TransactionRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            TransactionRowView(transaction: Transaction(id: "", userId: "", fromAccountId: "H5xTa17a8ChCwsPFFyOo", type: .income, currency: .uah, category: .family, amount: 228, date: Date(), note: "", recurring: false))
//                .preferredColorScheme(.dark)
//            TransactionRowView(transaction: Transaction(id: "", userId: "", fromAccountId: "3a6LSNqV2lUQdtEgLqQe", type: .expense, currency: .eur, category: .gifts, amount: 1337, date: Date(), note: "", recurring: false))
//        }
//    }
//}

