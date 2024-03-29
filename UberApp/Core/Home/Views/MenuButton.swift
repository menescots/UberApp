//
//  MenuButton.swift
//  UberApp
//
//  Created by Agata Menes on 03/03/2023.
//

import SwiftUI

struct MenuButton: View {
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel: LocationSearchViewModel
    //everytime we instantiate
    
    var body: some View {
        Button {
            withAnimation(.linear) {
                actionForState(state: mapState)
            }
        } label: {
            Image(systemName: imageNameForState(state: mapState))
                .font(.title)
                .foregroundColor(.gray)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func actionForState(state: MapViewState) {
        switch state {
        case .noInput:
            print("No input")
        case .searchingForLocation:
            mapState = .noInput
        case .locationSelected, .polylineAdded:
            mapState = .noInput
            viewModel.selectedUberLocation = nil
        }
    }
    
    func imageNameForState(state: MapViewState) -> String {
        switch state {
        case .noInput:
            return "line.3.horizontal"
        case .searchingForLocation, .polylineAdded, .locationSelected:
            return "arrow.left"
        default:
            return "line.3.horizontal"
        }
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuButton(mapState: .constant(.noInput))
    }
}
