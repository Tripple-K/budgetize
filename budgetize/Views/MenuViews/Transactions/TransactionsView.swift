
import SwiftUI
import FirebaseAuth

struct TransactionsView: View {
    
    @ObservedObject private var viewModel = TransactionsViewModel()
    
    @State var presentAddTransactionSheet = false
    
    private func transactionRowView(transaction: Transaction) -> some View {
        VStack {
            VStack(alignment: .leading) {
                Text(transaction.category.rawValue)
                    .font(.headline)
                Text("\(transaction.type.rawValue)")
                    .font(.subheadline)
            }
            Spacer()
            Text(String(format: "%.2f", transaction.amount))
            Text(String("\(transaction.date)"))
        }
    }
    
    
    var body: some View {
        VStack (spacing: 0) {
            ScrollView (.vertical, showsIndicators: false) {
                VStack (spacing: 0) {
                    ForEach(viewModel.transactions, id: \.self) { transaction in
                       
                            TransactionRecord(category: transaction.category, date: transaction.date, amount: transaction.amount)
                            if viewModel.transactions.last != transaction {
                                Rectangle()
                                    .padding(.horizontal, 40.0)
                                    .frame(height: 2.0)
                                    .foregroundColor(Color.gray)
                            }
                       
                    }
                }
            }
            HStack {
                Button(action: {
                    presentAddTransactionSheet.toggle()
                }, label: {
                    BrandButton(text: "+ Add transaction")
                })
            }
        }
        .sheet(isPresented: $presentAddTransactionSheet) {
            TransactionEditView()
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
