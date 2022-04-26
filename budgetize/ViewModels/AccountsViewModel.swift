import FirebaseFirestore
import FirebaseFirestoreSwift

class AccountsViewModel: ObservableObject {
    @Published var accounts = [Account]()
    
    private var db = Firestore.firestore()
    
    func showAccounts(_ userId: String) {
        db.collection("accounts")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { (querySnapshot, error) in
            guard let accounts = querySnapshot?.documents else {
                print("No accounts")
                return
            }
            self.accounts = accounts.compactMap { (queryDocumentSnapshot) -> Account? in
                print(accounts)
                return try! queryDocumentSnapshot.data(as: Account.self)
            }
        }
    }
}
