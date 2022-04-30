import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import Combine
import SwiftUI

struct ResultOf: Decodable {
    var result: Double = 0.0
}

class AccountsViewModel: ObservableObject{
    @Published var accounts = [Account]()

    @Published var balance = 0.0
    
    @AppStorage("mainCurrency") var mainCurrency: CurrencyType = .usd
    
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
                
                self.calculateBalance()
            }
    }
    
    func convert(amount: Double, from: CurrencyType, to: CurrencyType, completion: @escaping (Result<ResultOf, Error>)->Void) {
        let url = "https://api.exchangerate.host/convert?from=\(from.rawValue.uppercased())&to=\(to.rawValue.uppercased())&amount=\(Int(amount))"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { data, _, _ in
            guard let JSONData = data else { return }

            do {
                let conversion = try JSONDecoder().decode(ResultOf.self, from: JSONData)
                print(conversion.result)
                completion(.success(conversion))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func calculateBalance() {
        balance = 0
        accounts.forEach { account in
            if account.currency == mainCurrency {
                balance += account.balance
            } else {
                convert(amount: account.balance, from: account.currency, to: mainCurrency) { result in
                    switch result {
                    case .success(let resultOf):
                        print(resultOf.result)
                        self.balance += resultOf.result
                    case .failure(let error): print(error.localizedDescription)
                    }
                }
               
            }
        }
    }
}
