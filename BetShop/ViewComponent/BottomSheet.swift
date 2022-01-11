//
//  BottomSheet.swift
//  BetShop
//
//  Created by Jérémy Van Cauteren on 10/01/2022.
//

import SwiftUI

struct BottomSheet<SheetView>: ViewModifier where SheetView: View {

    // MARK: - Properties
    
    @Binding private var isPresented: Bool
    private let sheetView: SheetView
    
    // MARK: - Init's
    
    init(isPresented: Binding<Bool>, @ViewBuilder sheetView: () -> SheetView) {
        self._isPresented = isPresented
        self.sheetView = sheetView()
    }
    
    // MARK: - ViewModifier's
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .zIndex(0)
            
            if isPresented {
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        sheetView
                            .padding(.bottom, geometry.safeAreaInsets.bottom)
                            .padding(.top, 8)
                            .background(Color.white)
                            .cornerRadius(10, corners: [.topLeft, .topRight])
                    }
                    .ignoresSafeArea(edges: .bottom)
                }
                .transition(.move(edge: .bottom))
                .animation(.spring(response: 0.6, dampingFraction: 0.9, blendDuration: 1))
                .zIndex(1)
            }
        }
        .animation(.easeInOut, value: isPresented)
    }
    
}

extension View {
    
    func bottomSheet<SheetView: View>(isPresented: Binding<Bool>, @ViewBuilder sheetView: () -> SheetView) -> some View {
        modifier(BottomSheet(isPresented: isPresented, sheetView: sheetView))
    }
    
}
