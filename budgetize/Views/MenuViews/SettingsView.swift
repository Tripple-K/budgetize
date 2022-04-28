//
//  SettingsView.swift
//  budgetize
//
//  Created by Eugene Ned on 26.04.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("mainCurrency") var mainCurrency: CurrencyType = .usd
    
    var body: some View {
        Form {
            HStack {
                Text("Main currency")
                Picker(" ", selection: $mainCurrency) {
                    ForEach(CurrencyType.allCases, id: \.self)  { currency in
                        Text(currency.rawValue)
                            .tag(currency)
                    }
                }.pickerStyle(DefaultPickerStyle())
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
