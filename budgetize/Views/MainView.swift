import SwiftUI

enum Tabs: String {
    case Accounts
    case Transactions
    case Home
    case Overview
    case Settings
}

struct MainView: View {
    @ObservedObject var accountsViewModel = AccountsViewModel()
    @State var chosenTab: Tabs = .Home
    @Binding var endAnimation: Bool
    
    let frame: CGSize = UIScreen.main.bounds.size
    
    @AppStorage("mainCurrency") var mainCurrency: CurrencyType = .usd
    
    var navigationTitle: String {
        if chosenTab != .Settings {
            return String(format: "%.2f \(mainCurrency.rawValue.uppercased())", accountsViewModel.balance)
        }
        return "Settings"
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $chosenTab) {
                AccountsView()
                    .environmentObject(accountsViewModel)
                    .tabItem {
                        Label("Accounts", systemImage:"square.stack.3d.up")
                    }
                    .tag(Tabs.Accounts)
                TransactionsView()
                    .environmentObject(accountsViewModel)
                    .tabItem {
                        Label("Transactions", systemImage:"list.bullet.below.rectangle")
                    }
                    .tag(Tabs.Transactions)
                HomeView()
                    .environmentObject(accountsViewModel)
                    .tabItem {
                        Label("Home", systemImage:"circle.dotted")

                    }
                    .tag(Tabs.Home)
                OverView()
                    .environmentObject(accountsViewModel)
                    .tabItem{
                        Label("Overview", systemImage:"sum")
                    }
                    .tag(Tabs.Overview)
                SettingsView()
                    .tabItem{
                        Label("Settings", systemImage: "gear")
                    }
                    .tag(Tabs.Settings)
            }
            .navigationTitle(endAnimation ? navigationTitle : "")
            .navigationBarTitleDisplayMode(.inline)
            .offset(y: endAnimation ? 0 : frame.height)
        }
    }
}

