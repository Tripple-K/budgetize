
import SwiftUI
import FirebaseAuth

struct AccountsView: View {
    
    @ObservedObject private var viewModel = AccountsViewModel()
    
    @State private var presentAddAccountSheet = false
    
    private func accountRowView(account: Account) -> some View {
        NavigationLink(destination: AccountDetailsView(account: account)) {
            VStack(alignment: .leading) {
                Text(account.name)
                    .font(.headline)
                Text("\(account.type.rawValue)")
                    .font(.subheadline)
            }
            Spacer()
            Text(String(format: "%.2f", account.balance))
            Text(String("\(account.currency)"))
        }
    }
    
    var body: some View {
        VStack {
            List(viewModel.accounts) { account in
                accountRowView(account: account)
            }
            Button(action: { presentAddAccountSheet.toggle() }, label: { Text("Add account") } )
                .padding(11.0)
            Spacer()
        }
        .sheet(isPresented: $presentAddAccountSheet) {
            AccountEditView()
        }
    }
}

struct AccountsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsView()
    }
}

func addAccount() {
    
}
