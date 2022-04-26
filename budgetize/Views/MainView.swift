import SwiftUI

enum Tabs: String {
    case Accounts
    case Home
    case Transactions
    case Overview
}

struct MainView: View {
    @State var chosenTab: Tabs = .Home
    var body: some View {
        NavigationView {
            TabView(selection: $chosenTab) {
                AccountsView()
                    .tabItem {
                        Label("Accounts", systemImage:"1.square.fill")
                    }
                    .tag(Tabs.Accounts)
                HomeView()
                    .tabItem {
                        Label("Home", systemImage:"2.square.fill")
                    }
                    .tag(Tabs.Home)
                TransactionsView()
                    .tabItem {
                        Label("Transactions", systemImage:"3.square.fill")
                    }
                    .tag(Tabs.Transactions)
                OverView()
                    .tabItem{
                        Label("Overview", systemImage:"4.square.fill")
                    }
                    .tag(Tabs.Overview)
            }
            .navigationBarTitle(chosenTab.rawValue, displayMode: .inline)
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
