//
//  BetshopsMapView.swift
//  Betshop
//
//  Created by Jérémy Van Cauteren on 10/01/2022.
//

import SwiftUI
import MapKit

struct BetshopsMapView: View {
    
    @StateObject private var viewModel = BetshopsMapViewModel()
    
    @State private var isBetshopDetailViewPresented = false
    @State private var selectedBetshop: Betshop?
    
    var body: some View {
        fullMapView
            .ignoresSafeArea()
            .onAppear {
                viewModel.fetchData()
            }
            .bottomSheet(isPresented: $isBetshopDetailViewPresented) {
                if let betshop = selectedBetshop {
                    BetshopDetailView(isPresented: $isBetshopDetailViewPresented, betshop: betshop)
                }
            }
            .onChange(of: isBetshopDetailViewPresented) { isPresented in
                if !isPresented {
                    selectedBetshop = nil
                }
            }
    }
}

// MARK - Full map view

extension BetshopsMapView {
    
    private var fullMapView: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: viewModel.betshopList.betshops.prefix(500)) { betshop in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: betshop.location.latitude, longitude: betshop.location.longitude), anchorPoint: CGPoint(x: 0.5, y: 1)) {
                if betshop == selectedBetshop {
                    selectedAnnotationView
                } else {
                    defaultAnnotationView(betshop: betshop)
                }
            }
        }
    }
    
}

// MARK - Annotations

extension BetshopsMapView {
    
    private var selectedAnnotationView: some View {
        Image("selectedPin")
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 60)
    }
    
    private func defaultAnnotationView(betshop: Betshop) -> some View {
        Image("defaultPin")
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 40)
            .onTapGesture {
                selectedBetshop = betshop
                isBetshopDetailViewPresented = true
            }
    }
    
}

struct BetshopsMapView_Previews: PreviewProvider {
    static var previews: some View {
        BetshopsMapView()
    }
}
