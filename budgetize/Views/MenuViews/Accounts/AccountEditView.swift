
import SwiftUI
import FirebaseAuth

enum Mode {
    case new
    case edit
}

enum Action {
    case delete
    case done
    case cancel
}

struct AccountEditView: View {
    
    @StateObject var viewModel = AccountViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var presentActionSheet = false
    
    var mode: Mode = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?
    
    var cancelButton: some View {
        Button(action: { self.handleCancelTapped() }) {
            Text("Cancel")
        }
    }
    
    var createButton: some View {
        Button(action: { self.handleCreateTapped() }) {
            Text(mode == .new ? "Create" : "Save")
        }
        .disabled(!viewModel.modified)
    }
    
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
                
                if mode == .edit {
                    Section {
                        Button("Delete book") { self.presentActionSheet.toggle() }
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle(mode == .new ? "New account" : viewModel.account.name)
            .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
            .navigationBarItems(
                leading: cancelButton,
                trailing: createButton
            )
            .actionSheet(isPresented: $presentActionSheet) {
                ActionSheet(title: Text("Are you sure?"),
                            buttons: [
                                .destructive(Text("Delete book"),
                                             action: { self.handleDeleteTapped() }),
                                .cancel()
                            ])
            }
        }
    }
    
    func handleCancelTapped() {
        dismiss()
    }
    
    func handleCreateTapped() {
        viewModel.handleCreateTapped()
        dismiss()
    }
    
    func handleDeleteTapped() {
        viewModel.handleDeleteTapped()
        self.dismiss()
        self.completionHandler?(.success(.delete))
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
