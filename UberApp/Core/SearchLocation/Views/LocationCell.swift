//
//  LocationCell.swift
//  UberApp
//
//  Created by Agata Menes on 06/03/2023.
//

import SwiftUI

struct LocationCell: View {
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(Color(.systemMint))
                .tint(.white)
                .frame(width: 40,height: 40)
            VStack(alignment: .leading, spacing: 3) {
                Text("Starbucks")
                    .font(.system(size: 20))
                Text("Rynek, Wrocław 43/41")
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
        LocationCell()
    }
}
