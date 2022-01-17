//
//  BetshopNetworkManager.swift
//  BetShop
//
//  Created by Jérémy Van Cauteren on 10/01/2022.
//

import Foundation
import Moya
import CombineMoya
import Combine

class BetshopNetworkManager {
    
    // MARK: - Properties
    let provider = MoyaProvider<BetshopAPI>()
    
}

// MARK: - Fetch betshops

extension BetshopNetworkManager {
    func fetchBetshops(lat1: Double, long1: Double, lat2: Double, long2: Double) -> AnyPublisher<BetshopList, Error> {
        return provider.requestPublisher(.fetchBetshops(lat1: lat1, long1: long1, lat2: lat2, long2: long2))
            .map { $0.data }
            .decode(type: BetshopList.self, decoder: JSONDecoder())
            .mapError { error in
                switch error {
                case is Swift.DecodingError:
                    return AppError.parsingError
                default:
                    return AppError.networkError
                }
            }
            .eraseToAnyPublisher()
    }
}
