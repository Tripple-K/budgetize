import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class AccountViewModel: ObservableObject{
    @Published var account: Account?
    
    private let path: String = "accounts"
    private let store = Firestore.firestore()
    
    var accountId = ""
    
    func createAccount(_ account: Account) {
        do {
            var newAccount = account
            newAccount.id = accountId
        }
        
    }
    
    func editAccount() {
        
    }
    func deleteAccount() {
        
    }
    
    func showAllAccounts() {
        
    }
    
}
