import Firebase
import SwiftUI

@main
struct budgetizeApp: App {
    @StateObject var viewModel = GoogleAuthViewModel()
    
    init() {
        setupFirebase()
    }
    
    var body: some Scene {
        WindowGroup {
            InitView()
                .environmentObject(viewModel)
        }
    }
}

extension budgetizeApp {
    private func setupFirebase() {
        FirebaseApp.configure()
    }
}
