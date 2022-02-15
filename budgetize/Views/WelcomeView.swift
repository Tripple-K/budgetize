import FirebaseAuth

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @ObservedObject var userRepo = UserRepository()
    
    var body: some View {
        VStack {
            Spacer()
            Image("welcome")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("budgetize")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(Color(.systemIndigo))
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            Text("B is for the best")
                .fontWeight(.light)
                .multilineTextAlignment(.center)
            Spacer()
            Text("Sign in with Google".uppercased())
                .frame(minHeight: 50)
                .background(Color.black)
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding(20)
                .onTapGesture {
                    self.viewModel.login(with: "google.com") {
                        guard let user = Auth.auth().currentUser, let _ = user.displayName, let _ = user.email else { return }
                        userRepo.isExist(with: user.uid) { exist in
                            if !exist {
                                userRepo.add(UserInfo(userId: user.uid, displayName: user.displayName!, email: user.email!))
                            }
                        }
                    }
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
