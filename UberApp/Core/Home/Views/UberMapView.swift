//
//  UberMapView.swift
//  UberApp
//
//  Created by Agata Menes on 02/03/2023.
//

import SwiftUI
import MapKit
struct UberMapViewRepresentable: UIViewRepresentable {  //adding mapview to swift ui
    let mapView = MKMapView()
    let locationManager = LocationManager()
    
    @EnvironmentObject var locationViewModel: LocationSearchViewModel // we created enviromentObj to use one instance in our source code
    
    func makeUIView(context: Context) -> some UIView { //making mapview on view
        mapView.delegate = context.coordinator //  delegate
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let selectedLocation = locationViewModel.selectedLocationCoordinate {
            
            context.coordinator.addAndSelectAnnotation(withCoordinae: selectedLocation)
            context.coordinator.configurePolyline(withDestinationCoordinate: selectedLocation)
        }
        
    }
    
    func makeCoordinator() -> MapCoordinator {
       return MapCoordinator(parent: self)
        
    }
}

extension UberMapViewRepresentable {
    class MapCoordinator: NSObject, MKMapViewDelegate { //delegates from uikit, middleman between uikit and swiftui
        let parent: UberMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        var overlay: MKOverlay?
        
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) { //updating location
            self.userLocationCoordinate = userLocation.coordinate
            
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
            parent.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let over = MKPolylineRenderer(overlay: overlay)
            over.strokeColor = .systemRed
            over.lineWidth = 5
            return over
        }
        
        func addAndSelectAnnotation(withCoordinae coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations) // removin prevoius annotation before adding next on
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            parent.mapView.addAnnotation(annotation)
            parent.mapView.selectAnnotation(annotation, animated: true)
            
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true) // show region after adding annotation
        }
        
        func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destinationLocation: CLLocationCoordinate2D, completion: @escaping (MKRoute) -> Void) {
            let userPlacemark = MKPlacemark(coordinate: userLocation)
            let destinationPlacemark = MKPlacemark(coordinate: destinationLocation)
            
            let request = MKDirections.Request()
            
            request.source = MKMapItem(placemark: userPlacemark)
            request.destination = MKMapItem(placemark: destinationPlacemark)
            
            let directions = MKDirections(request: request)
            directions.calculate { response, error in
                guard  error == nil else { return }
                
                guard let route = response?.routes.first else { return }
                completion(route)
            }
        }
        
        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) { //line
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            
            getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
            }
        }
    }
}
