import SwiftUI

enum Tabs: String {
    case Accounts
    case Transactions
    case Home
    case Overview
    case Settings
}

struct MainView: View {
    @State var chosenTab: Tabs = .Home
    @Binding var endAnimation: Bool
    
    let frame: CGSize = UIScreen.main.bounds.size
    
    var body: some View {
        NavigationView {
            TabView(selection: $chosenTab) {
                AccountsView()
                    .tabItem {
                        Label("Accounts", systemImage:"square.stack.3d.up")
                    }
                    .tag(Tabs.Accounts)
                TransactionsView()
                    .tabItem {
                        Label("Transactions", systemImage:"list.bullet.below.rectangle")
                    }
                    .tag(Tabs.Transactions)
                HomeView()
                    .tabItem {
                        Label("Home", systemImage:"circle.dotted")

                    }
                    .tag(Tabs.Home)
                OverView()
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
            .navigationTitle(endAnimation ? chosenTab.rawValue : "" )
            .offset(y: endAnimation ? 0 : frame.height)
        }
    }
}

