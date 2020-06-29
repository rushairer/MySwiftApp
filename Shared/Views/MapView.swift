//
//  MapView.swift
//  Landmark
//
//  Created by Abenx on 2020/6/26.
//

import SwiftUI
import MapKit

struct MapView {
    var coordinate: CLLocationCoordinate2D
    
    func makeMapView() -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateMapView(_ view: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        view.setRegion(region, animated: true)
        view.addAnnotation(annotation)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(
                    latitude: 39.910358, longitude: 116.469841))
    }
}
