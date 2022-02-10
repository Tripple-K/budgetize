import Firebase
import SwiftUI

@main
struct budgetizeApp: App {
    @StateObject var viewModel = GoogleAuthViewModel()
    
    init() {
        setupAuthentication()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

extension budgetizeApp {
    private func setupAuthentication() {
        FirebaseApp.configure()
    }
}
