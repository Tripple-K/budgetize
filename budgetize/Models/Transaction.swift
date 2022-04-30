import SwiftUI
import FirebaseFirestoreSwift

struct Transaction: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var userId: String = ""
    var accountId: String = ""
    var type: TransactionType = .expense
    var currency: CurrencyType = .usd
    var category: CategoryType = .groceries
    var amount: Double = 0
    var date: Date = Date()
    var note: String = ""
    var recurring: Bool = false
    
    var month: String {
        if #available(iOS 15.0, *) {
            return date.formatted(.dateTime.year().month())
        }
        return ""
    }
}


enum TransactionType: String, Equatable, CaseIterable, Codable {
    case income = "Income"
    case expense = "Expense"
    case transfer = "Transfer"
}

enum CategoryType: String, Equatable, CaseIterable, Codable {
    case restaurant = "Restaurants"
    case leisure = "Leisure"
    case transport = "Transport"
    case groceries = "Groceries"
    case pets = "Pets"
    case health = "Health"
    case shopping = "Shopping"
    case family = "Family"
    case gifts = "Gifts"
    case house = "House"
    case bank = "Bank"
}
