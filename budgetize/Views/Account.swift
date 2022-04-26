import SwiftUI
import FirebaseFirestoreSwift

struct Account: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var color: String
    var type: AccountType
    var currency: CurrencyType
    var name: String
    var balance: Double
    
    init () {
        self.userId = ""
        self.color = ""
        self.type = .saving
        self.currency = .eur
        self.name = ""
        self.balance = 0
    }
}


enum AccountType: String, Equatable, CaseIterable, Codable {
    case creditCard = "Credit Card"
    case debitCard = "Debit Card"
    case cash = "Cash"
    case saving = "Saving Account"
}

