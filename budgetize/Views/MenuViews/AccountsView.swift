
import SwiftUI
import FirebaseAuth

struct AccountsView: View {
    
    @ObservedObject private var viewModel = AccountsViewModel()
    var userId = Auth.auth().currentUser?.uid
    
    var body: some View {
        VStack {
            List(viewModel.accounts) { account in
                HStack {
                    VStack(alignment: .leading) {
                        Text(account.name)
                            .font(.headline)
                        Text(String("\(account.type)"))
                            .font(.subheadline)
                    }
                    Spacer()
                    Text(String("\(account.balance)"))
                    Text(String("\(account.currency)"))
                }
                    
                    
                }
            Button("Add account", action: addAccount)
                .padding(11.0)
            Spacer()
        }
        .onAppear() {
            self.viewModel.showAccounts(userId ?? " ")
            print(userId)
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
