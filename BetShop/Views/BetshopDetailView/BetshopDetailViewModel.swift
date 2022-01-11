//
//  BetshopDetailViewModel.swift
//  BetShop
//
//  Created by Jérémy Van Cauteren on 10/01/2022.
//

import Foundation
import MapKit

class BetshopDetailViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var isOpen: Bool
    
    init() {
        let hour = Calendar.current.component(.hour, from: Date())
        isOpen = hour >= 8 && hour < 16
    }
    
}

// MARK: - Funcs

extension BetshopDetailViewModel {
    
    func openMap(for betshop: Betshop) {
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: betshop.location.latitude, longitude: betshop.location.longitude), addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = betshop.name
        mapItem.openInMaps(launchOptions: options)
    }
    
}
