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
    @Published var selectedLocationCoordinate: CLLocationCoordinate2D?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            print("query \(queryFragment)")
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    func selectLocation(_ location: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: location) { response, error in
            if error != nil {
                print("Cannot get coordinates")
                return
            }
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate //after searching gives coordinates
            self.selectedLocationCoordinate = coordinate
            print(coordinate)
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler ) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle) //look in full address title and subtitle
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion) //start searching for location
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) { //we are giving query fragment and receive search results
        self.results = completer.results
    }
}
