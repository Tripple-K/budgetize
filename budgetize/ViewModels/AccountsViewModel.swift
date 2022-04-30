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
    
    @Published var resultOfConversion = ResultOf()
    
    @AppStorage("mainCurrency") var mainCurrency: CurrencyType = .usd
    
    private let path: String = "accounts"
    private let store = Firestore.firestore()
    
    private var userId = ""
    
    init () {
        if let userId = Auth.auth().currentUser?.uid {
            self.userId = userId
            self.getAccounts()
            self.calculateBalance()
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
    
    func convert(amount: Double, from: CurrencyType, to: CurrencyType) {
        let url = "https://api.exchangerate.host/convert?from=\(from.rawValue.uppercased())&to=\(to.rawValue.uppercased())&amount=\(Int(amount))"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { [self] (data, _, _) in
//            guard let JSONData = data else { return }
            let JSONData = data

            do {
                let conversion = try JSONDecoder().decode(ResultOf.self, from: JSONData!)
                print(conversion)
                resultOfConversion = conversion
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func calculateBalance() -> Double {
        var balance: Double = 0
        accounts.forEach { account in
            if account.currency == mainCurrency {
                balance += account.balance
            } else {
                convert(amount: account.balance, from: account.currency, to: mainCurrency)
                print(resultOfConversion.result)
                balance += resultOfConversion.result
            }
        }
        print(balance)
        return balance
    }
}
