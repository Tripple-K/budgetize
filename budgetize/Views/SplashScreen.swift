
import SwiftUI

struct SplashScreen: View {
    
    @Binding var textAnimation: Bool
    @Binding var endAnimation: Bool
    
    let frame: CGSize = UIScreen.main.bounds.size
    
    var body: some View {
        VStack {
            ZStack {
                Text("budgetize")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(Color(.systemIndigo))
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .scaleEffect(endAnimation ? 0.75 : 1)
                    .offset(y: textAnimation ? -frame.height / 2 : frame.height / 2)
            }
            .frame(height: endAnimation ? 60 : nil)
            .zIndex(1)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}


