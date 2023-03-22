//
//  RideRequestView.swift
//  UberApp
//
//  Created by Agata Menes on 16/03/2023.
//

import SwiftUI

struct RideRequestView: View {
    @State private var selectedRideType: RideType = .uberX
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray4))
                .frame(width: 48, height: 6)
                .padding(.top, 5)
            HStack {
                VStack(){
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8, height: 8)
                    Rectangle()
                        .fill(Color(.systemGray2))
                        .frame(width: 2, height: 24)
                    Circle()
                        .fill(Color(.black))
                        .frame(width: 9, height: 9)
                }
                
                VStack(alignment: .leading, spacing: 14) {
                    HStack {
                        Text("Current location")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Text("1:30PM")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Text("Destination location")
                            .font(.system(size: 16, weight: .semibold))
                        
                        Spacer()
                        
                        Text("1:45PM")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.leading, 10)
            }
            .padding()
            Divider()
                .overlay(.gray)
            
            Text("SUGGESTED RIDES")
                .foregroundColor(.gray)
                .font(.subheadline)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
               
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(RideType.allCases) { rideType in
                        
                        VStack(alignment: .leading) {
                            Image(rideType.imageName)
                                .resizable()
                                .scaledToFit()
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(rideType.description)
                                    .font(.system(size: 14, weight: .semibold))
                                Text(locationViewModel.calculateRidePrice(forType: rideType).toCurrency())
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .padding(7)
                        }
                        .frame(width: 120, height: 140)
                        .foregroundColor(Color(rideType == selectedRideType ? .white : .black))
                        .background(Color(rideType == selectedRideType ? .systemPurple : .systemGray4))
                        .scaleEffect(rideType == selectedRideType ? 1.1 : 1.0)
                        .cornerRadius(13)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedRideType = rideType
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            Divider()
                .overlay(.gray)
                .padding(.vertical, 10)
            
            HStack {
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(5)
                    .background(Color(.systemBlue))
                    .cornerRadius(3)
                    .foregroundColor(.white)
                    .padding(.leading)
                Text("**** 1234")
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height: 50)
            .background(Color(.systemGray4))
            .cornerRadius(10)
            .padding(.horizontal)
            
            Button {
                
            } label: {
                Text("Confirm ride")
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .fontWeight(.bold)
                    .background(Color(.systemPurple))
                    .foregroundColor(Color(.white))
                    .cornerRadius(10)
            }

        }
        .padding(.bottom, 25)
        .background(.white)
        .cornerRadius(20)
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
