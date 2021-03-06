
import SwiftUI

struct CurrencyForm: View {
     
    @AppStorage("mainCurrency") var mainCurrency: CurrencyType = .usd
    var body: some View {
        Form {
            Text("Let's get to know each other better!")
                .font(.title)
            Section {
                Text("What's your main currency?")
                    .font(.title3)
                Picker("What's your main currency?", selection: $mainCurrency) {
                    ForEach(CurrencyType.allCases, id: \.self)  { currency in
                        Text(currency.rawValue)
                            .tag(currency)
                    }
                }.pickerStyle(WheelPickerStyle())
            }
        }
    }
}

struct CurrencyForm_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyForm()
    }
}

enum CurrencyType: String, Equatable, CaseIterable, Codable {
    case uah, eur, usd
    
    func getIconName() -> String {
        switch self {
        case .uah: return "hryvniasign.circle"
        case .eur: return "eurosign.circle"
        case .usd: return "dollarsign.circle"
        }
    }
}

