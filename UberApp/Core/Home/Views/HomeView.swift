//
//  HomeView.swift
//  UberApp
//
//  Created by Agata Menes on 02/03/2023.
//

import SwiftUI

struct HomeView: View {
    @State private var mapState = MapViewState.noInput
    
    var body: some View {
        ZStack(alignment: .top) {
            UberMapViewRepresentable(mapState: $mapState)
                .ignoresSafeArea()
            
            
            if mapState == .searchingForLocation {
                LocationSearchViewActivated(mapState: $mapState)
                
            } else if mapState == .noInput {
                HomeViewLocationSearchViewBar()
                    .padding(.top, 72)
                    .onTapGesture {
                        mapState = .searchingForLocation // when we tap to search for location
                    }
            }
            MenuButton(mapState: $mapState)
                .padding(.leading)
                .padding(.top, 3)
        }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
