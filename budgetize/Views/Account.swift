import SwiftUI
import FirebaseFirestoreSwift

struct Account: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var userId: String = ""
    var color: String = ""
    var type: AccountType = .debitCard
    var currency: CurrencyType = .usd
    var name: String = ""
    var balance: Double = 0
}


enum AccountType: String, Equatable, CaseIterable, Codable {
    case creditCard = "Credit Card"
    case debitCard = "Debit Card"
    case cash = "Cash"
    case saving = "Saving Account"
}

