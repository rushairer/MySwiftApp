//
//  MapView+Extension.swift
//  iOS
//
//  Created by Abenx on 2020/6/28.
//

import SwiftUI
import MapKit

extension MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        makeMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        updateMapView(uiView, context: context)
    }
}
