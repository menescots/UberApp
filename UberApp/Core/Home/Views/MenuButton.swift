//
//  MenuButton.swift
//  UberApp
//
//  Created by Agata Menes on 03/03/2023.
//

import SwiftUI

struct MenuButton: View {
    @Binding var showLocationSearchBarView: Bool //everytime we instantiate
    var body: some View {
        Button {
            showLocationSearchBarView.toggle()
        } label: {
            Image(systemName: "line.3.horizontal")
                .font(.title)
                .foregroundColor(.gray)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)

    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuButton(showLocationSearchBarView: .constant(true))
    }
}
