//
//  BetshopLocation.swift
//  BetShop
//
//  Created by Jérémy Van Cauteren on 10/01/2022.
//

import Foundation

struct BetshopLocation {
    let latitude: Double
    let longitude: Double
}

extension BetshopLocation: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
    
}
