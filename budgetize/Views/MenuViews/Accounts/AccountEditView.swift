
import SwiftUI
import FirebaseAuth

struct AccountEditView: View {
    
    @StateObject var viewModel = AccountViewModel()

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Account")) {
                    TextField("Name", text: $viewModel.account.name)
                    Picker("Account type", selection: $viewModel.account.type) {
                        ForEach(AccountType.allCases, id: \.self)  { type in
                            Text(type.rawValue)
                                .tag(type)
                        }
                    }.pickerStyle(DefaultPickerStyle())
                    Picker("Currency", selection: $viewModel.account.currency) {
                        ForEach(CurrencyType.allCases, id: \.self)  { currency in
                            Text(currency.rawValue)
                                .tag(currency)
                        }
                    }.pickerStyle(DefaultPickerStyle())
                    
                }
                Section(header: Text("Balance")) {
                    TextField("Balance", value: $viewModel.account.balance, formatter: NumberFormatter())
                }
            }
            .navigationBarTitle("New account", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: { handleCancelTapped() }, label: {
                    Text("Cancel")
                }),
                trailing: Button(action: { handleCreateTapped() }, label: {
                    Text("Create")
                })
            )
        }
    }
    
    func handleCancelTapped() {
        dismiss()
    }
    
    func handleCreateTapped() {
        viewModel.save()
        dismiss()
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct AccountEditView_Previews: PreviewProvider {
    static var previews: some View {
        AccountEditView()
    }
}
