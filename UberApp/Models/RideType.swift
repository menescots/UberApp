//
//  RideType.swift
//  UberApp
//
//  Created by Agata Menes on 21/03/2023.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
case uberX
case uberBlack
case uberXL
    
    var id: Int { return rawValue }
    
    var description: String {
        switch self {
        case .uberX: return "UberX"
        case .uberBlack: return "UberBlack"
        case .uberXL: return "UberXL"
        }
    }
    
    var imageName: String {
        switch self {
        case .uberX: return "uber-x"
        case .uberBlack: return "uber-black"
        case .uberXL: return "uber-x"
        }
    }
    
    var baseFare: Double {
        switch self {
        case .uberX:
            return 5
        case .uberBlack:
            return 18
        case .uberXL:
            return 23
        }
    }
    
    func calculatePrice(for distanceInMeters: Double) -> Double {
        let distanceInKm = distanceInMeters / 1000
        
        switch self {
        case .uberX:
            return distanceInKm * 1.7 + baseFare
        case .uberBlack:
            return distanceInKm * 2.1 + baseFare
        case .uberXL:
            return distanceInKm * 2.4 + baseFare
        }
    }
}
