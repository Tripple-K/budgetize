
import SwiftUI

struct TransactionEditView: View {
    
    @StateObject var viewModel = TransactionViewModel()
    @StateObject var accountsViewModel = AccountsViewModel()
    @StateObject var accountViewModel = AccountViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var presentActionSheet = false

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
                Picker("Account", selection: $viewModel.transaction.accountId) {
                    ForEach(accountsViewModel.accounts, id: \.self)  { account in
                        Text(account.name)
                            .tag(String(account.id ?? ""))
                    }
                }
                .onChange(of: viewModel.transaction.accountId) { newValue in
                    accountViewModel.getAccount(with: newValue)
                }
                .pickerStyle(DefaultPickerStyle())
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
            viewModel.transaction.accountId = defaultAccount ?? ""
        }
    }
    
    func handleCancelTapped() {
        dismiss()
    }
    
    func handleCreateTapped() {
        
        switch mode {
        case .new:
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
