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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        checkAuthorizationStatus()
        
        mapViewConfig()
        
    }
    
    private func mapViewConfig() {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 152.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        view = mapView
        
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

extension ViewController: CLLocationManagerDelegate {
    
}

