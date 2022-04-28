
import SwiftUI

struct AccountForm: View {
    
    @StateObject var viewModel: AccountViewModel
    
    var body: some View {
        Form {
            Section(header: Text("Account")) {
                TextField("Name", text: $viewModel.account.name)
                Picker("Account type", selection: $viewModel.account.type) {
                    ForEach(AccountType.allCases, id: \.self)  { type in
                        Text(type.rawValue)
                            .tag(type)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                Picker("Currency", selection: $viewModel.account.currency) {
                    ForEach(CurrencyType.allCases, id: \.self)  { currency in
                        Text(currency.rawValue)
                            .tag(currency)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
            }
            Section(header: Text("Balance")) {
                TextField("Balance", value: $viewModel.account.balance, formatter: NumberFormatter())
            }
        }
        
    }
}



struct AccountForm_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AccountViewModel()
        AccountForm(viewModel: viewModel)
    }
}

