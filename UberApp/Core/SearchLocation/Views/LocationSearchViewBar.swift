//
//  LocationSearch.swift
//  UberApp
//
//  Created by Agata Menes on 03/03/2023.
//

import SwiftUI

struct LocationSearchViewBar: View {
    var body: some View {
        HStack {
            Circle()
                .fill(Color.black)
                .frame(width: 8, height: 8)
                .padding(.horizontal)
            
            Text("Where do you want to go?")
                .foregroundColor(Color(.darkGray))
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 70,
               height: 44)
        .background(
            Rectangle()
            .fill(.white))
        .shadow(color: .black, radius: 14)
        
    }
}

struct LocationSearch_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchViewBar()
    }
}
