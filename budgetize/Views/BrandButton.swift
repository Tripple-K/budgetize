//
//  BrandButton.swift
//  budgetize
//
//  Created by Eugene Ned on 28.04.2022.
//

import SwiftUI

struct BrandButton: View {
    var text: String = "+"
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.systemIndigo))
                .frame(width: text == "+" ? 50 : .infinity, height: 50)
            Text(text)
                .font(.title2)
                .foregroundColor(Color.white)
        }
        .padding()
    }
}

struct BrandButton_Previews: PreviewProvider {
    static var previews: some View {
        BrandButton(text: "budgetize")
    }
}
