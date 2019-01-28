//
//  ViewController.swift
//  BungSeGwon
//
//  Created by jinsunkim on 15/01/2019.
//  Copyright © 2019 jinsunkim. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class ViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    private var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView = GMSMapView()
        view = mapView
        
        locationManager.delegate = self
        checkAuthorizationStatus()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.isMyLocationEnabled = true
        move(at: locationManager.location?.coordinate)

    }

    
    private func checkAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedWhenInUse:
            fallthrough
        case .authorizedAlways:
            startUpdatingLocation()
            
        }
        
    }
    
    private func startUpdatingLocation() {
        let status = CLLocationManager.authorizationStatus()
        guard status == .authorizedAlways || status == .authorizedWhenInUse, CLLocationManager.locationServicesEnabled()
            else { return }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }


}

extension  ViewController {
    private func move(at coordinate: CLLocationCoordinate2D?) {
        guard let coordinate = coordinate else { return }
        let latitude = coordinate.latitude
        let logitude = coordinate.longitude
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: logitude, zoom: 16.0)
        mapView.camera = camera
        
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let firstLocation = locations.first else { return }
        move(at: firstLocation.coordinate)
    }
    
}

