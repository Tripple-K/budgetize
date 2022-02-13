//
//  ContentView.swift
//  budgetize
//
//  Created by Eugene Ned on 10.02.2022.
//

import SwiftUI

struct InitView: View {
    @EnvironmentObject var viewModel: GoogleAuthViewModel
    
    
    var body: some View {
        if viewModel.user != nil {
            OnboardingView()
        } else {
            WelcomeView()
        }
    }
}
