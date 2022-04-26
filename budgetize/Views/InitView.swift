

import SwiftUI
import FirebaseAuth

struct InitView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var showWelcomeView = Auth.auth().currentUser != nil ? false : true
    
    var body: some View {
        OnboardingView().fullScreenCover(isPresented: $showWelcomeView) {
            WelcomeView(showWelcomeView: $showWelcomeView)
        }
    }
}
