import FirebaseAuth

import SwiftUI
import AuthenticationServices
import CryptoKit

struct WelcomeView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @ObservedObject var userRepo = UserRepository()
    
    @State var currentNonce:String?
    
    var body: some View {
        VStack {
            Spacer()
            Image("welcome")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("budgetize")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(Color(.systemIndigo))
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            Text("B is for the best")
                .fontWeight(.light)
                .multilineTextAlignment(.center)
            Spacer()
            Text("Sign in with Google".uppercased())
                .frame(minHeight: 50)
                .background(Color.black)
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding(20)
                .onTapGesture {
                    self.viewModel.login(with: "google.com") {
                        guard let user = Auth.auth().currentUser, let _ = user.displayName, let _ = user.email else { return }
                        userRepo.isExist(with: user.uid) { exist in
                            if !exist {
                                userRepo.add(UserInfo(userId: user.uid, displayName: user.displayName!, email: user.email!))
                            }
                        }
                    }
            }
            
            DynamicAppleSignIn(onRequest: { request in
                let nonce = AppleAuth.shared.randomNonceString()
                currentNonce = nonce
                request.requestedScopes = [.fullName, .email]
                request.nonce = sha256(nonce)
            }, onCompletion: { result in
                handleResultAuth(result)
            })
                .frame(minHeight: 50)
                .cornerRadius(10)
                .padding()
        }
    }
    
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    func handleResultAuth(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authResults):
            switch authResults.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                guard let nonce = currentNonce else {
                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
                }
                guard let appleIDToken = appleIDCredential.identityToken else {
                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
                }
                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                    print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                    return
                }
                
                let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, accessToken: nonce)
                Auth.auth().signIn(with: credential) { (authResult, error) in
                    if (error != nil) {
                        print(error?.localizedDescription as Any)
                        return
                    }
                    guard let user = Auth.auth().currentUser else {
                        print("No user")
                        return
                    }
                    userRepo.isExist(with: user.email!) { exist in
                        if !exist {
                            userRepo.add(UserInfo(userId: user.uid, displayName: user.displayName ?? "User", email: user.email!))
                        }
                    }
                }
                
                print("\(String(describing: Auth.auth().currentUser?.uid))")
            default:
                break
                
            }
        default:
            break
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

struct DynamicAppleSignIn : View {
    @Environment(\.colorScheme) var colorScheme
    
    var onRequest: (ASAuthorizationAppleIDRequest) -> Void
    var onCompletion: ((Result<ASAuthorization, Error>) -> Void)
    
    var body: some View {
        
        switch colorScheme {
        case .dark:
            SignInWithAppleButton(
                onRequest: onRequest,
                onCompletion: onCompletion
            ).signInWithAppleButtonStyle(.white)
        case .light:
            SignInWithAppleButton(
                onRequest: onRequest,
                onCompletion: onCompletion
            ).signInWithAppleButtonStyle(.black)
        @unknown default:
            fatalError("Not Yet Implemented")
        }
        
    }
}
