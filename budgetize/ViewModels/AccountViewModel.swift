import Firebase
import FirebaseAuth
import Foundation

class AccountViewModel: ObservableObject {
    @Published var account: Account = Account(userId: "", color: "", type: .debitCard, currency: .usd, name: "", balance: 0)
    
    private let store = Firestore.firestore()
    
    private var userId = ""
    
    init () {
        if let userId = Auth.auth().currentUser?.uid {
            self.userId = userId
        }
    }
    
    func createAccount(_ account: Account) {
        do {
            self.account.userId = userId
            let _ = try store.collection("accounts").addDocument(from: self.account)
        } catch {
            print(error)
        }
        
    }
    
    func save() {
        createAccount(account)
    }
}
