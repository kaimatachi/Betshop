//
//  BetshopManager.swift
//  Betshop
//
//  Created by Jérémy Van Cauteren on 10/01/2022.
//

import Foundation
import MapKit
import Combine

class BetshopManager {
    
    // MARK: - Properties
    private let networkManager = BetshopNetworkManager()
    
}

// MARK: - Fetch

extension BetshopManager {
    
    func fetchBetshops(for location: MKCoordinateRegion) -> AnyPublisher<BetshopList, Error> {
        let lat1 = Double(location.center.latitude + location.span.latitudeDelta)
        let long1 = Double(location.center.longitude + location.span.longitudeDelta)
        let lat2 = Double(location.center.latitude - location.span.latitudeDelta)
        let long2 = Double(location.center.longitude - location.span.longitudeDelta)
        
        return networkManager.fetchBetshops(lat1: lat1,
                                            long1: long1,
                                            lat2: lat2,
                                            long2: long2)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
