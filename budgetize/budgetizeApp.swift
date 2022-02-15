import SwiftUI
import Firebase

@main
struct budgetizeApp: App {
    @StateObject var viewModel = GoogleAuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            InitView()
                .environmentObject(viewModel)
        }
    }
}

//extension budgetizeApp {
//    private func setupFirebase() {
//        FirebaseApp.configure()
//    }
//}
