//
//  BetshopList.swift
//  BetShop
//
//  Created by Jérémy Van Cauteren on 10/01/2022.
//

import Foundation

struct BetshopList: Decodable {
    let count: Int
    let betshops: [Betshop]
}
