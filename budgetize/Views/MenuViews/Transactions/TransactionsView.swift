
import SwiftUI
import FirebaseAuth

struct TransactionsView: View {
    
    @EnvironmentObject var accountsViewModel: AccountsViewModel
    @ObservedObject private var viewModel = TransactionsViewModel()
    
    @State var presentAddTransactionSheet = false
    
    var body: some View {
        ZStack {
            VStack (spacing: 0) {
                ScrollView (.vertical, showsIndicators: false) {
                    VStack (spacing: 0) {
                        ForEach(Array(viewModel.groupTransactionByMonth()), id: \.key) { month, transactions in
                            Section {
                                ForEach(transactions) { transaction in
                                    TransactionRowView(transaction: transaction).environmentObject(accountsViewModel)
                                    
                                }
//                                .onDelete(perform: { index in
//                                    viewModel.transactions.remove(atOffsets: index)
//                                })
                            } header: {
                                Divider()
                                HStack{
                                    Text(month)
                                        .padding()
                                    Spacer()
                                }
                                Divider()
                                
                            }
                        }
                    }
                }
                
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        presentAddTransactionSheet.toggle()
                    }, label: {
                        if viewModel.transactions.isEmpty {
                            BrandButton(text: "+ Add transaction")
                        } else {
                            BrandButton(text: "+")
                        }
                    })
                }
            }
            .padding()
            .sheet(isPresented: $presentAddTransactionSheet) {
                TransactionEditView()
            }
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
