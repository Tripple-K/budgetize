//
//  OnboardingView.swift
//  budgetize
//
//  Created by Eugene Ned on 13.02.2022.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var viewModel: GoogleAuthViewModel

    var body: some View {
        VStack {
            Spacer()
            Text("Welcome to budgetize!")
            Spacer()
//            Button(action: viewModel.signOut) {
//                Text("Sign out")
//            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
