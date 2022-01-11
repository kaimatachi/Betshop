//
//  BetshopDetailView.swift
//  BetShop
//
//  Created by Jérémy Van Cauteren on 10/01/2022.
//

import SwiftUI

struct BetshopDetailView: View {
    
    @Binding var isPresented: Bool
    
    let betshop: Betshop
    
    @StateObject private var viewModel = BetshopDetailViewModel()
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                addressLabel
                
                HStack {
                    openingLabel
                    
                    Divider()
                        .frame(height: 20)
                    
                    routeButton
                }
                .padding(.leading, 28)
            }
            
            Spacer()
            
            closeButton
        }
        .padding()
    }
    
    
}

// MARK - Labels views

extension BetshopDetailView {
    
    private var addressLabel: some View {
        HStack(alignment: .top) {
            Image("location")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(betshop.name)
                
                Text(betshop.address)
                
                Text("\(betshop.city) - \(betshop.county)")
            }
        }
    }
    
    @ViewBuilder
    private var openingLabel: some View {
        if viewModel.isOpen {
            Text("Open now until 16:00")
                .bold()
                .foregroundColor(Color.green)
        } else {
            Text("Opens tomorrow at 08:00")
                .bold()
                .foregroundColor(Color.blue)
        }
    }
    
}

// MARK - Buttons

extension BetshopDetailView {
    
    private var closeButton: some View {
        Button {
            isPresented = false
        } label: {
            Image("close")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
        }
    }
    
    private var routeButton: some View {
        Button {
            viewModel.openMap(for: betshop)
        } label: {
            Text("Route")
                .foregroundColor(Color.blue)
                .bold()
        }
    }
    
}

struct BetshopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let betshop = Betshop(id: 2350429, name: "Westenriederstrasse 37", county: "Bayern", cityId: 80331, city: "Muenchen", address: "80331 Muenchen", location: BetshopLocation(latitude: 11.5796763, longitude: 48.1351722))
        BetshopDetailView(isPresented: .constant(true), betshop: betshop)
            .previewLayout(.sizeThatFits)
    }
}
