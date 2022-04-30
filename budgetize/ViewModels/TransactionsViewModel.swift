import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import Combine
import Collections
import SwiftUI

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>

struct Wedge: Hashable {
    var startAngle: Double
    var endAngle: Double
    var color: Color
    var category: CategoryType
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

class TransactionsViewModel: ObservableObject{
    @Published var transactions = [Transaction]()
    
    private let path: String = "transactions"
    private let store = Firestore.firestore()
    
    private var userId = ""
    
    public var amount: Double {
        var amount = 0.0
        _ = transactions.compactMap { transaction in
            amount += transaction.amount
        }
        return amount
    }
    
    init () {
        if let userId = Auth.auth().currentUser?.uid {
            self.userId = userId
            self.getTransactions()
        }
    }
    
    func getTransactions() {
        store.collection(path)
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
    
    func getTransactionsByType(_ type: TransactionType) {
        store.collection(path)
            .whereField("userId", isEqualTo: userId)
            .whereField("type", isEqualTo: type.rawValue)
            .addSnapshotListener { query, error in
                if let error = error {
                    print(error.localizedDescription)
                    
                }
                
                guard let transactions = query?.documents else {
                    print("no transactions")
                    return
                }
                
                self.transactions = transactions.compactMap { transaction in
                    return try? transaction.data(as: Transaction.self)
                }
            }
    }
    
    func getTransactionsByCategory(_ category: CategoryType) -> [Transaction] {
        return self.transactions.filter { transaction in
            transaction.category == category
        }
    }
    
    func getActiveWedges() -> [Wedge] {
        var wedges = [Wedge]()
        var start = 0.0
        var end = 0.0
        for category in CategoryType.allCases {
            guard getTransactionsByCategory(category).count > 0 else { continue }
            start = end
            end += countAmountForCategory(category)
            let wedge = Wedge(startAngle: start, endAngle: end, color: Color.random, category: category)
            wedges.append(wedge)
        }
        return wedges
    }
    
    func countAmountForCategory(_ category: CategoryType) -> Double {
        let transactions = getTransactionsByCategory(category)
        var amount = 0.0
        _ = transactions.compactMap { transaction in
            amount += transaction.amount
        }
        return amount / self.amount
    }
    
}
