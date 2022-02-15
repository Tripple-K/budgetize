
import GoogleSignIn
import FirebaseAuth

struct OAuthService {
    
    var provider: OAuthProvider
    
    init (with providerID: String) {
        provider = OAuthProvider(providerID: providerID)
        provider.scopes = ["user:email"]
    }
    
    func processLogin(completion: @escaping () -> Void) {
        do {
            let config = GIDConfiguration.getGIDConfigurationInstance()
            let uiViewController = try UIApplication.getRootViewController()
            
            GIDSignIn.sharedInstance.signIn(with: config, presenting: uiViewController) { user, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                guard let authentication = user?.authentication,
                      let idToken = authentication.idToken else {
                          print("Can't get google user credentials")
                          return
                      }
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
                
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    guard let _ = authResult?.credential as? OAuthCredential else { return }
                    
                    completion()
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
