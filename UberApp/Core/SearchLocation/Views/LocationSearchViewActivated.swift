//
//  SearchView.swift
//  UberApp
//
//  Created by Agata Menes on 06/03/2023.
//

import SwiftUI

struct LocationSearchViewActivated: View {
    
    @State private var startLocationText = ""
    @Binding var showLocationSearchView: Bool
    
    @EnvironmentObject var viewModel: LocationSearchViewModel
    var body: some View {
        VStack {
            HStack {
                VStack{
                    Circle()
                        .fill(Color(.gray))
                        .frame(width: 6, height: 6)
                    Rectangle()
                        .fill(Color(.gray))
                        .frame(width: 2, height: 24)
                    Circle()
                        .fill(Color(.black))
                        .frame(width: 7, height: 7)
                }
                
                VStack {
                    TextField("Current location", text: $startLocationText)
                        .frame(height: 37)
                        .background(Color(.systemGray5))
                        .padding(.trailing)
                        .cornerRadius(14)
                    
                    TextField("Where to?", text: $viewModel.queryFragment)
                        .frame(height: 37)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                        .cornerRadius(14)
                }
            }.padding(.horizontal)
                .padding(.top, 60)
           
            Divider()
                .overlay(.gray)
                .padding(.vertical)
            
            ScrollView(){
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(viewModel.results, id: \.self) { result in
                        SearchLocationResultCell(title: result.title, subtitle: result.subtitle)
                            .onTapGesture {
                                withAnimation {
                                    viewModel.selectLocation(result)
                                    showLocationSearchView.toggle()
                                }
                            }
                    }
                }
            }
        }
        .background(.white)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchViewActivated(showLocationSearchView: .constant(true))
    }
}