//
//  RideRequestView.swift
//  UberApp
//
//  Created by Agata Menes on 16/03/2023.
//

import SwiftUI

struct RideRequestView: View {
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray4))
                .frame(width: 48, height: 6)
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
                    ForEach(0 ..< 3, id: \.self) { _ in
                        
                        VStack(alignment: .leading) {
                            Image("uber-x")
                                .resizable()
                                .scaledToFit()
                            
                            VStack(spacing: 4) {
                                Text("UberX")
                                    .font(.system(size: 14, weight: .semibold))
                                Text("244$")
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .padding(7)
                        }
                        .frame(width: 120, height: 140)
                        .background(Color(.systemGray4))
                        .cornerRadius(13)
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
                    .background(Color(.systemBlue))
                    .foregroundColor(Color(.white))
                    .cornerRadius(10)
            }

        }
        .background(.white)
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
