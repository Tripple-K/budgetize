
import SwiftUI

struct CurrencyForm: View {
     
    @AppStorage("mainCurrency") var mainCurrency: CurrencyType = .usd
    var body: some View {
        VStack {
            Text("What's your main currency?")
            Picker("What's your main currency?", selection: $mainCurrency) {
                ForEach(CurrencyType.allCases, id: \.self)  { currency in
                    Text(currency.rawValue)
                        .tag(currency)
                    
                }
            }.pickerStyle(WheelPickerStyle())
        }
    }
}

struct CurrencyForm_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyForm()
    }
}

enum CurrencyType: String, Equatable, CaseIterable, Codable {
    case uah, euro, usd
}
