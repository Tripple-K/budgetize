
import SwiftUI

struct AccountForm: View {
    
//    var account = Account()
    
    @State var accountName = ""
    @State var accountCurrency: CurrencyType = .usd
    var accountType: AccountType = .debitCard
//    @State var color
    
    
    var body: some View {
        VStack {
            Text("Let's create your first account!")
                .font(.largeTitle.bold())
                .padding()
            HStack {
                Text("Name")
                TextField("Name", text:$accountName)
            }
            Text("What's account currency?")
            Picker("What's your account currency?", selection: $accountCurrency) {
                ForEach(CurrencyType.allCases, id: \.self)  { currency in
                    Text(currency.rawValue)
                        .tag(currency)

                }
            }.pickerStyle(WheelPickerStyle())
//            ColorPicker("Choose account color", selection: <#T##Binding<CGColor>#>)
//
            
            Spacer()
            
        }
    }
}

struct AccountForm_Previews: PreviewProvider {
    static var previews: some View {
        AccountForm()
    }
}
 
