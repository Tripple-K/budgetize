
import Foundation
import Firebase
import GoogleSignIn
import SwiftUI


class AuthViewModel: ObservableObject {
    @Published var user: User?
    
    private var authenticationStateHandler: AuthStateDidChangeListenerHandle?
    
    init () {
        addListeners()
    }
    
    private func addListeners() {
        if let handle = authenticationStateHandler {
            Auth.auth().removeStateDidChangeListener(handle)
        }
        authenticationStateHandler = Auth.auth()
            .addStateDidChangeListener { _, user in
                self.user = user
            }
    }
    
    func login(with providerID: String, completion: @escaping () -> Void) {
        let oauthProvider = OAuthService(with: providerID)
        oauthProvider.processLogin(completion: completion)
    }
    
    func logOut() {
        guard let user = Auth.auth().currentUser else { return }
        switch user.providerID {
        case "google.com":
            GIDSignIn.sharedInstance.signOut()
        default:
            break
        }
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}

