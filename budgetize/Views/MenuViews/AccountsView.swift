
import SwiftUI
import FirebaseAuth

struct AccountsView: View {
    
    @ObservedObject private var viewModel = AccountViewModel()
    
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
    }
}

struct AccountsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsView()
    }
}

func addAccount() {
    
}
