

import SwiftUI
import Firebase

struct OnboardingView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @AppStorage("firstContact") var firstContact = true
    
    @State var selectedSubveiw = 0
    let lastSubview = 1
    let frame = UIScreen.main.bounds
    
    @State var endAnimation = false
    @State var textAnimation = false

    var body: some View {
//        if firstContact {
//            VStack {
//                VStack {
//                    TabView(selection: $selectedSubveiw) {
//                        CurrencyForm().tag(0)
//                        AccountForm().tag(1)
//                    }
//                    .tabViewStyle(PageTabViewStyle())
//                }
//                Button(action: {
//                    if selectedSubveiw == lastSubview {
//                        firstContact = false
//                    } else {
//                        selectedSubveiw += 1
//                    }
//                }, label: {
//                    Text("\(selectedSubveiw == lastSubview ? "Finish" : "Next" )".uppercased())
//                        .padding()
//                        .cornerRadius(10)
//                        .background(Color(.systemIndigo))
//                })
//            }.onAppear()
//        } else {
//            MainView()
//        }
        ZStack {
            MainView(endAnimation: $endAnimation)
                .frame(width: frame.width, height: frame.height)
            SplashScreen(textAnimation: $textAnimation, endAnimation: $endAnimation)
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(.spring()) {
                    textAnimation.toggle()
                }
                
                withAnimation(Animation.interactiveSpring(response: 0.6, dampingFraction: 1, blendDuration: 1)) {
                    endAnimation.toggle()
                }
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}


