
import SwiftUI
import FirebaseFirestoreSwift

struct UserInfo: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var displayName: String
    var email: String
    var mainCurrency: CurrencyType?
    var accounts: [Account]?
    var avatar: String?
}

