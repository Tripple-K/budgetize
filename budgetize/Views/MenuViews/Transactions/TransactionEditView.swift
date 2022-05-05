
import SwiftUI

struct TransactionEditView: View {
    
    @StateObject var viewModel = TransactionViewModel()
    @StateObject var accountsViewModel = AccountsViewModel()
    @StateObject var accountViewModel = AccountViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var presentActionSheet = false
    
    @State var showTransferElements = false
    
    @AppStorage("defaultAccount") var defaultAccount: String?
    
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
                Text("NEW TRANSACTION")
                    .font(.footnote)
                    .fontWeight(.light)
                HStack {
                    Spacer()
                    TextField("Amount", value: $viewModel.transaction.amount, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                Picker(showTransferElements ? "From account" : "Account", selection: $viewModel.transaction.fromAccountId) {
                    ForEach(accountsViewModel.accounts, id: \.self)  { account in
                        Text(account.name)
                            .tag(account.id ?? "")
                    }
                }.pickerStyle(DefaultPickerStyle())
                    .onChange(of: viewModel.transaction.fromAccountId) { newValue in
                        accountViewModel.getAccount(with: newValue)
                    }
                
                if showTransferElements {
                    Picker("To account", selection: $viewModel.transaction.toAccountId) {
                        ForEach(accountsViewModel.accounts, id: \.self)  { account in
                            Text(account.name)
                                .tag(account.id)
                        }
                    }
                }
                
                DatePicker(selection: $viewModel.transaction.date, in: ...Date(), displayedComponents: .date) {
                    Text("Select a date")
                }
                Picker("Category", selection: $viewModel.transaction.category) {
                    ForEach(CategoryType.allCases, id: \.self)  { category in
                        Text(category.rawValue)
                            .tag(category)
                    }
                }.pickerStyle(DefaultPickerStyle())
                
                Picker("Type", selection: $viewModel.transaction.type) {
                    ForEach(TransactionType.allCases, id: \.self)  { type in
                        Text(type.rawValue)
                            .tag(type)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .onChange(of: viewModel.transaction.type) { transactionType in
                        if transactionType == .transfer {
                            showTransferElements = true
                        } else { showTransferElements = false }
                    }
                
                TextField("Note", text: $viewModel.transaction.note)
                
                if mode == .edit {
                    Section {
                        Button("Delete transaction") { self.presentActionSheet.toggle() }
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: cancelButton,
                trailing: createButton
            )
            .actionSheet(isPresented: $presentActionSheet) {
                ActionSheet(title: Text("Are you sure?"),
                            buttons: [
                                .destructive(Text("Delete transaction"),
                                             action: { self.handleDeleteTapped() }),
                                .cancel()
                            ])
            }
        }
        .onAppear {
            viewModel.transaction.fromAccountId = defaultAccount ?? ""
        }
    }
    
    func handleCancelTapped() {
        dismiss()
    }
    
    func handleCreateTapped() {
        
        switch mode {
        case .new:
            viewModel.transaction.currency = accountViewModel.account.currency
            viewModel.addTransaction()
            accountViewModel.changeBalance(with: viewModel.transaction)
        case .edit:
            viewModel.updateTransaction()
        }
        
        dismiss()
    }
    
    func handleDeleteTapped() {
        viewModel.deleteTransaction()
        self.dismiss()
        self.completionHandler?(.success(.delete))
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct TransactionEditView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionEditView()
    }
}
