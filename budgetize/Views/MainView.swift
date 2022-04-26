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
    @State var endAnimation = false
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
                        //                        Label("Transactions", systemImage:"cart")
                    }
                    .tag(Tabs.Transactions)
                HomeView()
                    .tabItem {
                        Label("Home", systemImage:"circle.dotted")
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
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
            
            .offset(y: endAnimation ? -5 : 470)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.spring()){
                    endAnimation.toggle()
                }
            }
        }
    }
}
        //
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
