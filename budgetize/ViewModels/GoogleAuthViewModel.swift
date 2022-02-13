
import Foundation
import Firebase
import GoogleSignIn
import SwiftUI


class GoogleAuthViewModel: ObservableObject {
    @Published var user: User?
    @ObservedObject var userRepo = UserRepository()
    
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
    
    func signIn() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                authenticateUser(for: user, with: error)
            }
        } else {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            let configuration = GIDConfiguration(clientID: clientID)
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            
            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
                authenticateUser(for: user, with: error)
            }
        }
    }
    
    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let user = user, let idToken = user.authentication.idToken, let userId = user.userID else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            self.userRepo.isExist(with: userId) { exist in
                if !exist {
                    self.userRepo.add(UserInfo(userId: userId, displayName: user.profile?.name ?? "", email: user.profile?.email ?? ""))
                }
            }
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}

