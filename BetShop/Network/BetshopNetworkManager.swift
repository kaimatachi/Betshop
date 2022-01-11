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
            .mapError { _ in
                return AppError.networkError
            }
            .tryMap { response in
                do {
                    return try JSONDecoder().decode(BetshopList.self, from: response.data)
                } catch {
                    throw AppError.parsingError
                }
            }
            .eraseToAnyPublisher()
    }
}
