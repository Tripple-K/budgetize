import Firebase
import SwiftUI
import UIKit
import GoogleSignIn


class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct budgetizeApp: App {
    @StateObject var viewModel = AuthViewModel()

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            InitView()
                .environmentObject(viewModel)
        }
    }
}

extension UIApplication {

    /// Get root UIViewController of application. If for whatever reason, UIViewController cannot be accessed,
    /// invoke fatalError() since UIViewController instance is crucial for application to work properly.
    /// - Returns: root UIViewController
    static func getRootViewController() throws -> UIViewController {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first

        guard let uiViewController = window?.rootViewController else { fatalError() }
        return uiViewController
    }
}


