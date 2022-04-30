//
//  SettingsView.swift
//  budgetize
//
//  Created by Eugene Ned on 26.04.2022.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    
    @ObservedObject var viewModel = AuthViewModel()
    
    @State var showWelcomeView = Auth.auth().currentUser != nil ? false : true
    
    @AppStorage("mainCurrency") var mainCurrency: CurrencyType = .usd
    
    var body: some View {
        VStack {
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
            Spacer()
            Button {
                viewModel.logOut()
                showWelcomeView.toggle()
            } label: {
                Text("Log out")
            }
        }
        .fullScreenCover(isPresented: $showWelcomeView) {
            WelcomeView(showWelcomeView: $showWelcomeView)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
