//
//  LocationManager.swift
//  Betshop
//
//  Created by Jérémy Van Cauteren on 10/01/2022.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    private static let defaultLocation = CLLocationCoordinate2D(latitude: 48.137154, longitude: 11.576124)
    
    private let clLocationManager = CLLocationManager()
    private(set) var currentLocation = CurrentValueSubject<CLLocationCoordinate2D, Never>(defaultLocation)
    
    // MARK: Init
    
    private override init() {
        super.init()
        clLocationManager.delegate = self
    }
    
}

// MARK: funcs

extension LocationManager {
    
    func requestAuthorisation() {
        clLocationManager.requestWhenInUseAuthorization()
    }
    
}

// MARK: CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first?.coordinate {
            currentLocation.value = userLocation
        }
    }
    
}
