

import SwiftUI
import GoogleSignIn

struct OnboardingView: View {
    @EnvironmentObject var viewModel: GoogleAuthViewModel

    var body: some View {
        VStack {
            Spacer()
            Text("Onboarding!")
            Spacer()
            Button(action: viewModel.signOut) {
                Text("Sign out")
            }
        }
    }
}

struct OndoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
