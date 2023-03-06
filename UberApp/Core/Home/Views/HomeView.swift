//
//  HomeView.swift
//  UberApp
//
//  Created by Agata Menes on 02/03/2023.
//

import SwiftUI

struct HomeView: View {
    @State private var showLocationSearchView = false
    
    var body: some View {
        ZStack(alignment: .top) {
            UberMapViewRepresentable()
                .ignoresSafeArea()
            
            
                if showLocationSearchView {
                    LocationSearchViewActivated(showLocationSearchView: $showLocationSearchView)
                } else {
                LocationSearchViewBar()
                        .padding(.top, 72)
                        .onTapGesture {
                                showLocationSearchView.toggle()
                        }
                }
            MenuButton(showLocationSearchBarView: $showLocationSearchView)
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
