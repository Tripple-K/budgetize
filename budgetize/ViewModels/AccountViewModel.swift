import Firebase
import FirebaseAuth
import Combine

class AccountViewModel: ObservableObject {
    @Published var account: Account
    @Published var modified = false
    
    private var userId = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(account: Account = Account(userId: "", color: "", type: .debitCard, currency: .usd, name: "", balance: 0)) {
        self.account = account
        if let userId = Auth.auth().currentUser?.uid {
            self.userId = userId
        }
        
        self.$account
          .dropFirst()
          .sink { [weak self] account in
            self?.modified = true
          }
          .store(in: &self.cancellables)
      }
    
    private let store = Firestore.firestore()
    
    func addAccount(_ account: Account) {
        do {
            self.account.userId = userId
            let _ = try store.collection("accounts").addDocument(from: self.account)
        } catch {
            print(error)
        }
        
    }
    

    
    
    private func updateAccount(_ account: Account) {
        if let documentId = account.id {
          do {
            try store.collection("accounts").document(documentId).setData(from: account)
          }
          catch {
            print(error)
          }
        }
      }
    
    private func updateOrAddAccount() {
        if let _ = account.id {
          self.updateAccount(self.account)
        }
        else {
          addAccount(account)
        }
      }
      
      private func deleteAccount() {
        if let documentId = account.id {
            store.collection("accounts").document(documentId).delete { error in
            if let error = error {
              print(error.localizedDescription)
            }
          }
        }
      }
    
    
    func handleCreateTapped() {
        self.updateOrAddAccount()
      }
      
      func handleDeleteTapped() {
        self.deleteAccount()
      }
}
