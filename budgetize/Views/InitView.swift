

import SwiftUI

struct InitView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    var body: some View {
        if viewModel.user != nil {
            OnboardingView()
        } else {
            WelcomeView()
        }
    }
}
