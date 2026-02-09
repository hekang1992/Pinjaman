//
//  LocationService.swift
//  UangCair
//
//  Created by Daniel Thomas Miller on 2026/1/29.
//

import UIKit
import CoreLocation

class LocationStorage {
    
    private enum Keys {
        static let longitude = "longitude"
        static let latitude = "latitude"
    }
    
    static func save(latitude: String, longitude: String) {
        UserDefaults.standard.set(latitude, forKey: Keys.latitude)
        UserDefaults.standard.set(longitude, forKey: Keys.longitude)
    }
    
    static var storedLongitude: String {
        return UserDefaults.standard.string(forKey: Keys.longitude) ?? ""
    }
    
    static var storedLatitude: String {
        return UserDefaults.standard.string(forKey: Keys.latitude) ?? ""
    }
}

class LocationService: NSObject {
    
    typealias LocationDataCompletion = ([String: String]?) -> Void
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    
    private lazy var geocoder = CLGeocoder()
    
    private var completionHandler: LocationDataCompletion?
    
    func requestCurrentLocation(completion: @escaping LocationDataCompletion) {
        self.completionHandler = completion
        
        checkAuthorizationAndStart()
    }
    
    private func checkAuthorizationAndStart() {
        let status: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            
        case .restricted, .denied:
            handleError()
            
        @unknown default:
            handleError()
        }
    }
    
    private func stopTracking() {
        locationManager.stopUpdatingLocation()
    }
    
    private func handleError() {
        completionHandler?(nil)
        stopTracking()
    }
    
    private func processLocation(_ location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Reverse geocode failed: \(error.localizedDescription)")
                self.handleError()
                return
            }
            
            guard let placemark = placemarks?.first else {
                self.handleError()
                return
            }
            
            let latString = String(location.coordinate.latitude)
            let longString = String(location.coordinate.longitude)
            LocationStorage.save(latitude: latString, longitude: longString)
            
            let infoDict = self.mapPlacemarkToDictionary(placemark, location: location)
            
            self.completionHandler?(infoDict)
            
            self.stopTracking()
        }
    }
    
    private func mapPlacemarkToDictionary(_ placemark: CLPlacemark, location: CLLocation) -> [String: String] {
        return [
            "curvon": placemark.administrativeArea ?? "",
            "numberen": placemark.isoCountryCode ?? "",
            "corcy": placemark.country ?? "",
            "billion": placemark.thoroughfare ?? "",
            "phaey": String(location.coordinate.latitude),
            "pickics": String(location.coordinate.longitude),
            "expertth": placemark.locality ?? "",
            "bacistic": placemark.subLocality ?? ""
        ]
    }
    
    deinit {
        stopTracking()
        print("LocationService deinitialized")
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        processLocation(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clError = error as? CLError, clError.code == .locationUnknown {
            return
        }
        handleError()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            handleError()
        default:
            break
        }
    }
}
