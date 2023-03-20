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
    
    func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.completion = completion
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
    
//    var locationManager: CLLocationManager?
//    @Published var lastLocation: CLLocation?
//    @Published var allowLocation: Bool = false
//
//    func checkIfLocationServicesIsEnabled() {
//        DispatchQueue.main.async {
//            if CLLocationManager.locationServicesEnabled() {
//                self.locationManager = CLLocationManager()
//                self.locationManager!.delegate = self
//                self.locationManager!.distanceFilter = 500.0
//                self.locationManager!.startUpdatingLocation()
//            } else {
//                print("Show an alert or show error page because location is not on...")
//            }
//        }
//
//    }
//
//    private func checkLocationAuthorization() {
//        guard let locationManager = locationManager else { return }
//
//        switch locationManager.authorizationStatus {
//
//            case .notDetermined:
//                locationManager.requestWhenInUseAuthorization()
//            case .restricted:
//                print("Your location is restricted")
//            case .denied:
//                print("Your have denied this app location permission. Please go into the setting and change it")
//            case .authorizedAlways, .authorizedWhenInUse:
//                self.allowLocation = true
//                break
//            @unknown default:
//                break
//        }
//    }
//
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        checkLocationAuthorization()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        lastLocation = location
//        print(#function, location)
//    }
}
