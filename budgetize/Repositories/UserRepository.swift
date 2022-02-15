
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class UserRepository: ObservableObject {
    
    private let path: String = "usersInfo"
    private let store = Firestore.firestore()

    @Published var user: UserInfo?

    var userId = ""

    private let authenticationService = AuthViewModel()
    private var cancellables: Set<AnyCancellable> = []

    init() {
        authenticationService.$user
            .compactMap { user in
                user?.uid
            }
            .assign(to: \.userId, on: self)
            .store(in: &cancellables)

        authenticationService.$user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.get()
            }
            .store(in: &cancellables)
    }


    func get() {
        store.collection(path)
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting cards: \(error.localizedDescription)")
                    return
                }

                guard let document = querySnapshot?.documents.first else {
                    return
                }
                self.user = try? document.data(as: UserInfo.self)
            }
    }

    func isExist(with userId: String, completion: @escaping (Bool) -> Void) {
        store.collection(path)
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting cards: \(error.localizedDescription)")
                    completion(false)
                }
                guard let _ = querySnapshot?.documents.first else {
                    completion(false)
                    return
                }
                completion(true)
            }
    }


    func add(_ user: UserInfo) {
        do {
            var newUser = user
            newUser.id = userId
            _ = try store.collection(path).addDocument(from: newUser)
        } catch {
            fatalError("Unable to add user: \(error.localizedDescription).")
        }
    }

    func update(_ user: UserInfo) {

        guard let userId = user.id else { return }
        do {

            try store.collection(path).document(userId).setData(from: user)
        } catch {
            fatalError("Unable to update user: \(error.localizedDescription).")
        }
    }

    func remove(_ user: UserInfo) {

        guard let userId = user.id else { return }

        store.collection(path).document(userId).delete { error in
            if let error = error {
                print("Unable to remove user: \(error.localizedDescription)")
            }
        }
    }
}
