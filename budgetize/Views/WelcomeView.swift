//
//  WelcomeView.swift
//  budgetize
//
//  Created by Eugene Ned on 09.02.2022.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var viewModel: GoogleAuthViewModel
    
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
                    self.viewModel.signIn()
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
