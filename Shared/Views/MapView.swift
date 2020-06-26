//
//  MapView.swift
//  Landmark
//
//  Created by Abenx on 2020/6/26.
//

import SwiftUI
import MapKit

#if !os(macOS)
struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        self.updateView(uiView, context: context)
    }
}
#else
struct MapView: NSViewRepresentable {
    var coordinate: CLLocationCoordinate2D

    func makeNSView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateNSView(_ nsView: MKMapView, context: Context) {
        self.updateView(nsView, context: context)
    }
}
#endif

extension MapView {
    func updateView(_ uiView: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        uiView.setRegion(region, animated: true)
        uiView.addAnnotation(annotation)
    }
}
    

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(
                    latitude: 39.910358, longitude: 116.469841))
    }
}
