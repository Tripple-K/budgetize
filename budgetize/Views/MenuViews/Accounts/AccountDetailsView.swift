//
//  AccountDetailsView.swift
//  budgetize
//
//  Created by Eugene Ned on 26.04.2022.
//

import SwiftUI

struct AccountDetailsView: View {
    // MARK: - State
    
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditAccountSheet = false
    
    // MARK: - State (Initialiser-modifiable)
    
    var account: Account
    
    // MARK: - UI Components
    
    private func editButton(action: @escaping () -> Void) -> some View {
        Button(action: { action() }) {
            Text("Edit")
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Account details")) {
                
                HStack {
                    Text(account.name)
                        .font(.title2)
                    Spacer()
                    Text(String(format: "%.2f", account.balance))
                    Image(systemName: account.currency.getIconName())
                }
                HStack {
                    Text("Account type")
                    Spacer()
                    Text("\(account.type.rawValue)")
                }
            }
        }
        .navigationBarTitle(account.name)
        .navigationBarItems(trailing: editButton {
            self.presentEditAccountSheet.toggle()
        })
        .sheet(isPresented: self.$presentEditAccountSheet) {
            AccountEditView(viewModel: AccountViewModel(account: account), mode: .edit) { result in
                if case .success(let action) = result, action == .delete {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
        
    }
}

struct AccountDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let account = Account(userId: "", color: "black", type: .debitCard, currency: .uah, name: "monobank black", balance: 27353)
        AccountDetailsView(account: account)
    }
}
