import SwiftUI
import FirebaseFirestoreSwift

struct Account: Codable {
    @DocumentID var id: String?
    var userId: String
    var color: String
    var accountType: AccountType
    var currency: CurrencyType
    var name: String
}


enum AccountType: String, Codable {
    case creditCard = "Credit Card"
    case debitCard = "Debit Card"
    case cash = "Cash"
    case saving = "Saving Account"
}
