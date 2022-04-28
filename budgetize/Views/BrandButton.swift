//
//  BrandButton.swift
//  budgetize
//
//  Created by Eugene Ned on 28.04.2022.
//

import SwiftUI

struct BrandButton: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.title2)
            .foregroundColor(Color.white)
            .padding(.horizontal, 90.0)
            .padding(.vertical, 15.0)
            .background(Color(.systemIndigo))
            .cornerRadius(40)
    }
}

struct BrandButton_Previews: PreviewProvider {
    static var previews: some View {
        BrandButton(text: "budgetize")
    }
}
