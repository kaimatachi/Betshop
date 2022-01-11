//
//  Betshop.swift
//  Betshop
//
//  Created by Jérémy Van Cauteren on 10/01/2022.
//

import Foundation

struct Betshop: Identifiable {
    let id: Int
    let name: String
    let county: String
    let cityId: Int
    let city: String
    let address: String
    let location: BetshopLocation
}

extension Betshop: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case cityId = "city_id"
        case id, name, county, city, address, location
    }
    
}

extension Betshop: Equatable {
    
    static func == (lhs: Betshop, rhs: Betshop) -> Bool {
        lhs.id == rhs.id
    }
    
}
