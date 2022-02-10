//
//  ContentView.swift
//  budgetize
//
//  Created by Eugene Ned on 10.02.2022.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var viewModel: GoogleAuthViewModel
  
  var body: some View {
      if viewModel.state == .signedIn {
          OnboardingView()
      } else {
          WelcomeView()
      }
    
  }
}
