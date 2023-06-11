//
//  LocationManager.swift
//  Foozy
//
//  Created by Jeff Deng on 3/19/23.
//

import CoreLocation
import SwiftUI

class LocationManagerViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    // singleton pattern
    static let shared = LocationManagerViewModel()
    
    let manager = CLLocationManager()
    
    var completion: ((CLLocation) -> Void)?
    
    private var isUpdatingLocation = false
    
    func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        // Ignore subsequent calls until the previous call has completed
        guard !isUpdatingLocation else { return }
        isUpdatingLocation = true
        
        self.completion = { location in
            self.isUpdatingLocation = false
            completion(location)
        }
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        completion?(location)
        manager.stopUpdatingLocation()
    }
}
