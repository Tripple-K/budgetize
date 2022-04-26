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
    
    func addAccount() {
        do {
            account.userId = Auth.auth().currentUser?.uid ?? ""
            let _ = try store.collection("accounts").addDocument(from: account)
        } catch {
            print(error)
        }
    }
    
    func updateAccount() {
        if let id = account.id {
            do {
                try store.collection("accounts").document(id).setData(from: account)
            }
            catch {
                print(error)
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
    
}
