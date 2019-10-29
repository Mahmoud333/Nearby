//
//  MALocationManager.swift
//  RestaurantsMenu
//
//  Created by Mahmoud Hamad on 10/24/19.
//  Copyright © 2019 Algorithm. All rights reserved.
//

import UIKit
import CoreLocation

class MALocationManager: NSObject {
    
    var locationManager: CLLocationManager!
    weak var viewController: UIViewController?
    
    var updatedLocation: ((CLLocation?) -> ())?
    var lastLocation: CLLocation?
    
    init(viewController: UIViewController) {
        super.init()
        self.viewController = viewController
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        checkAuthorization()
    }
    
    func checkAuthorization() -> Bool {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse :
            print("Auth: authorizedAlways, authorizedWhenInUse")
            return true
            
        case .notDetermined:
            print("Auth: notDetermined")
            locationManager.requestWhenInUseAuthorization()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.checkAuthorization()
            }
            return false
        case .restricted, .denied:
            let alert = UIAlertController(title: "Enable location permission", message: "To auto detect location, please enable location services for this app", preferredStyle: .alert)
            alert.view.tintColor = .black
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Settings", style: .default) { [weak self] (alert) in
                guard let weakSelf = self else {print("return 802"); return}
                let url = URL(string: UIApplication.openSettingsURLString)
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url!, options: [:], completionHandler: { (success) in
                    })
                } else {
                    UIApplication.shared.openURL(url!)
                }
            })
            self.viewController?.present(alert, animated: true, completion: nil)
            return false
        }
    }
    
    private func translateCoordinatesToAddress(location: CLLocation, completion: @escaping (String) -> () ) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placeMarks, error) in
            guard let weakSelf = self else {print("return 802"); return}
            if error == nil, let placemark = placeMarks?.first {
                var addressString : String = ""
                if placemark.isoCountryCode == "TW" /*Address Format in Chinese*/ {
                    if placemark.country != nil {
                        addressString = placemark.country!
                    }
                    if placemark.subAdministrativeArea != nil {
                        addressString = addressString + placemark.subAdministrativeArea! + " | " //", "
                    }
                    if placemark.postalCode != nil {
                        addressString = addressString + placemark.postalCode! + " | "//" "
                    }
                    if placemark.locality != nil {
                        addressString = addressString + placemark.locality!
                    }
                    if placemark.thoroughfare != nil {
                        addressString = addressString + placemark.thoroughfare!
                    }
                    if placemark.subThoroughfare != nil {
                        addressString = addressString + placemark.subThoroughfare!
                    }
                } else {
                    if placemark.subThoroughfare != nil {
                        addressString = placemark.subThoroughfare! + " | "//" "
                    }
                    if placemark.thoroughfare != nil {
                        addressString = addressString + placemark.thoroughfare! + " | "//", "
                    }
                    if placemark.postalCode != nil {
                        addressString = addressString + placemark.postalCode! + " | "//" "
                        //cell.postalTF.text = placemark.postalCode!
                    }
                    if placemark.locality != nil {
                        addressString = addressString + placemark.locality! + " | "//", "
                        //                            cell.areaTF.text = placemark.locality
                    }
                    if placemark.administrativeArea != nil {
                        addressString = addressString + placemark.administrativeArea! + " | "//" "
                        //                            cell.cityTF.text = placemark.administrativeArea!
                    }
                    if placemark.country != nil {
                        addressString = addressString + placemark.country!
                        //cell.countryTF.text = placemark.country!
                    }
                }
                print("Address: \(addressString)")
                completion(addressString)
            }
        }
    }
}

extension MALocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if lastLocation != nil {
            let distance =  locations.last?.distance(from: lastLocation!)
            if distance! >= 500.0 {
                self.updatedLocation?(locations.last)
                lastLocation = locations.last
            }
        } else {
            self.updatedLocation?(locations.last)
            lastLocation = locations.last
        }
    }
}


extension MALocationManager {
    func currentLocation() -> (latitude: CLLocationDegrees, longitude: CLLocationDegrees)? {
        guard checkAuthorization() == true else { return nil }
        let latitude = CLLocationDegrees(exactly: locationManager.location?.coordinate.latitude ?? 0.0)!
        let longitude =  CLLocationDegrees(exactly: locationManager.location?.coordinate.longitude ?? 0.0)!
        return (latitude: latitude, longitude: longitude)
    }
}
