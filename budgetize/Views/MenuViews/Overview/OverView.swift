
import SwiftUI
import SwiftUICharts

struct OverView: View {
    var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]
    
    var body: some View {
        VStack {
            CardView {
                ChartLabel(" ")
                LineChart()
            }
            .data(demoData)
            .chartStyle(ChartStyle(backgroundColor: Color.white, foregroundColor: ColorGradient(Color(.systemIndigo).opacity(0.4), Color(.systemIndigo))))
            .padding([.horizontal, .top])
                
            
            RecentTransactionsView()
                .padding()
            
        }
    }
}

struct OverView_Previews: PreviewProvider {
    static var previews: some View {
        OverView()
    }
}
