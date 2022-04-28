import Firebase
import FirebaseAuth
import Combine

class TransactionViewModel: ObservableObject {
    @Published var transaction: Transaction
    @Published var modified = false
    
    private var userId = ""
    private let store = Firestore.firestore()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.transaction = Transaction()
        self.$transaction
            .dropFirst()
            .sink { [weak self] transaction in
                self?.modified = true
            }
            .store(in: &self.cancellables)
    }
    
    convenience init(_ transaction: Transaction) {
        self.init()
        
        self.transaction = transaction
        if let userId = Auth.auth().currentUser?.uid {
            self.userId = userId
        }
    }
    
    func addTransaction() {
        do {
            transaction.userId = Auth.auth().currentUser?.uid ?? ""
            let _ = try store.collection("transactions").addDocument(from: transaction)
        } catch {
            print(error)
        }
    }
    
    func updateTransaction() {
        if let id = transaction.id {
            do {
                try store.collection("transactions").document(id).setData(from: transaction)
            } catch {
                print(error)
            }
        }
    }
    
    func deleteTransaction() {
        if let id = transaction.id {
            store.collection("transactions").document(id).delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
