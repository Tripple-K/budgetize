import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>

class TransactionsViewModel: ObservableObject{
    @Published var transactions = [Transaction]()
    
    private let path: String = "transactions"
    private let store = Firestore.firestore()
    
    private var userId = ""
    
    init () {
        if let userId = Auth.auth().currentUser?.uid {
            self.userId = userId
            self.getTransactions()
        }
    }
    
    func getTransactions() {
        store.collection("transactions")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { (querySnapshot, error) in
            guard let transactions = querySnapshot?.documents else {
                print("No transactions")
                return
            }
            self.transactions = transactions.compactMap { (queryDocumentSnapshot) ->
                Transaction? in
                return try? queryDocumentSnapshot.data(as: Transaction.self)
            }
        }
    }
    
    func groupTransactionByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }
        
        let sortedTransactions = transactions.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        let groupedTransactions = TransactionGroup(grouping: sortedTransactions) { $0.month }
        
        return groupedTransactions
    }
    
}
