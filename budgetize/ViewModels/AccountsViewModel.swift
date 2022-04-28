import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import Combine

class AccountsViewModel: ObservableObject{
    @Published var accounts = [Account]()
    var balance: Double {
        var balance: Double = 0
        accounts.forEach { account in
            balance += account.balance
        }
        return balance
    }
    
    private let path: String = "accounts"
    private let store = Firestore.firestore()
    
    private var userId = ""
    
    init () {
        if let userId = Auth.auth().currentUser?.uid {
            self.userId = userId
            self.getAccounts()
        }
    }
    
    func getAccounts() {
        store.collection("accounts")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { (querySnapshot, error) in
            guard let accounts = querySnapshot?.documents else {
                print("No accounts")
                return
            }
            
            self.accounts = accounts.compactMap { (queryDocumentSnapshot) -> Account? in
                return try? queryDocumentSnapshot.data(as: Account.self)
            }
        }
    }
    
}
