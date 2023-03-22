//
//  LocationSearchViewModel.swift
//  UberApp
//
//  Created by Agata Menes on 06/03/2023.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedUberLocation: UberLocation?
    @Published var pickUpTime: String?
    @Published var dropOff: String?
    
    private let searchCompleter = MKLocalSearchCompleter()
    
    var queryFragment: String = "" {
        didSet {
            print("query \(queryFragment)")
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    func selectLocation(_ location: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: location) { response, error in
            if let error = error {
                print("Cannot get coordinates \(error.localizedDescription)")
                return
            }
            
            guard let item = response?.mapItems.first else { return }
            
            let coordinate = item.placemark.coordinate //after searching gives coordinates
            self.selectedUberLocation = UberLocation(title: location.title, coordinate: coordinate)
            print("Location coordinates found: \(coordinate)")
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler ) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle) //look in full address title and subtitle
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion) //start searching for location
    }
    
    func calculateRidePrice(forType type: RideType) -> Double {
        guard let coordinate = selectedUberLocation?.coordinate  else { return 0.0}
        guard let userLocation = self.userLocation else { return 0.0}
        
        let userlocation = CLLocation(latitude: userLocation.latitude,
                                      longitude: userLocation.longitude)
        let destination = CLLocation(latitude: coordinate.latitude,
                                     longitude: coordinate.longitude)
        
        let distance = userlocation.distance(from: destination)
        return type.calculatePrice(for: distance)
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
            self.configurePickUpAndDropOffTimes(with: route.expectedTravelTime)
            completion(route)
        }
    }
    
    func configurePickUpAndDropOffTimes(with expectedTravelTime: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        pickUpTime = formatter.string(from: Date())
        dropOff = formatter.string(from: Date() + expectedTravelTime)
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) { //we are giving query fragment and receive search results
        self.results = completer.results
    }
}
