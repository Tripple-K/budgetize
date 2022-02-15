

import SwiftUI
import Firebase

struct OnboardingView: View {
    @EnvironmentObject var viewModel: GoogleAuthViewModel
    @AppStorage("firstContact") var firstContact = true
    
    @State var selectedSubveiw = 0
    let lastSubview = 1

    var body: some View {
        if !firstContact {
            VStack {
                VStack {
                    TabView(selection: $selectedSubveiw) {
                        CurrencyForm().tag(0)
                        AccountForm().tag(1)
                    }
                    .tabViewStyle(PageTabViewStyle())
                }
                Button(action: {
                    if selectedSubveiw == lastSubview {
                        firstContact = false
                    } else {
                        selectedSubveiw += 1
                    }
                }, label: {
                    Text("\(selectedSubveiw == lastSubview ? "Finish" : "Next" )".uppercased())
                        .padding()
                        .cornerRadius(10)
                        .background(Color(.systemIndigo))
                })
            }.onAppear()
        } else {
            MainView()
        }
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}


