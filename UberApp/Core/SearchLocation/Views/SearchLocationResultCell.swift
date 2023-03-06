//
//  LocationCell.swift
//  UberApp
//
//  Created by Agata Menes on 06/03/2023.
//

import SwiftUI

struct SearchLocationResultCell: View {
    let title: String
    let subtitle: String
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(Color(.systemMint))
                .tint(.white)
                .frame(width: 40,height: 40)
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 20))
                Text(subtitle)
                    .font(.system(size: 16))
                    .foregroundColor(Color(.darkGray))
                
                Divider()
                    .overlay(.gray)
            }
        }
        .padding(.leading)
    }
}

struct LocationCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchLocationResultCell(title: "Starbucks", subtitle: "123 Street")
    }
}
