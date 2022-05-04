import Firebase
import FirebaseAuth
import Combine

class AccountViewModel: ObservableObject {
    @Published var account: Account
    @Published var modified = false
    
    private var userId = ""
    private let store = Firestore.firestore()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.account = Account()
        self.$account
            .dropFirst()
            .sink { [weak self] account in
                self?.modified = true
            }
            .store(in: &self.cancellables)
    }
    
    convenience init (_ account: Account) {
        self.init()
        
        self.account = account
        if let userId = Auth.auth().currentUser?.uid {
            self.userId = userId
        }
    }
    
    func getAccount(with accountId: String) {
        store.collection("accounts")
            .document(accountId).getDocument { querySnapshot, error in
                if let error = error {
                    print("Error getting cards: \(error.localizedDescription)")
                    return
                }
                
                if let account = try? querySnapshot?.data(as: Account.self) {
                    self.account = account
                }
            }
    }
    
    func addAccount() {
        do {
            account.userId = Auth.auth().currentUser?.uid ?? ""
            let _ = try store.collection("accounts").addDocument(from: account)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateAccount() {
        if let id = account.id {
            do {
                try store.collection("accounts").document(id).setData(from: account)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteAccount() {
        if let id = account.id {
            store.collection("accounts").document(id).delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func changeBalance(with transaction: Transaction) {
        switch transaction.type {
        case .income:
            account.balance += transaction.amount
        case .expense:
            account.balance -= transaction.amount
        case .transfer:
            transferBalance()
        }
        if let accountId = account.id {
            do {
                try store.collection("accounts").document(accountId).setData(from: account)
            } catch {
                print(error.localizedDescription)
            }
           
        }
    }
    
    func transferBalance() {
        
    }
    
}
