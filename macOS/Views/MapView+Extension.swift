//
//  MapView+Extension.swift
//  macOS
//
//  Created by Abenx on 2020/6/28.
//

import SwiftUI
import MapKit

extension MapView: NSViewRepresentable {
    func makeNSView(context: Context) -> MKMapView {
        makeMapView()
    }
    
    func updateNSView(_ nsView: MKMapView, context: Context) {
        updateMapView(nsView, context: context)
    }
}
