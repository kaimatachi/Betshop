//
//  BetshopsMapViewModel.swift
//  Betshop
//
//  Created by Jérémy Van Cauteren on 10/01/2022.
//

import Foundation
import Combine
import MapKit

class BetshopsMapViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    @Published var region = MKCoordinateRegion(center: LocationManager.shared.currentLocation.value, span: defaultSpan)
    @Published var betshopList = BetshopList(count: 0, betshops: [])
    
    private var betshopManager = BetshopManager()
    private var regionCancellables: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    
}

// MARK: - Fetch data

extension BetshopsMapViewModel {
    
    func fetchData() {
        LocationManager.shared.requestAuthorisation()
        LocationManager.shared.currentLocation
            .sink { [weak self] newLocation in
                guard let self = self else { return }
                self.region = MKCoordinateRegion(center: newLocation, span: self.region.span)
            }
            .store(in: &cancellables)
        
        regionCancellables = $region
            .throttle(for: 2, scheduler: DispatchQueue.main, latest: true)
            .handleEvents(receiveRequest:  { [regionCancellables] _ in
                regionCancellables?.cancel()
            })
            .flatMap { [betshopManager] region in
                betshopManager.fetchBetshops(for: region)
                    .replaceError(with: BetshopList(count: 0, betshops: []))
            }
            .assign(to: \.betshopList, on: self)
    }
    
}
