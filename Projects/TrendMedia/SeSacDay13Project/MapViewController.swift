//
//  MapViewController.swift
//  SeSacDay13Project
//
//  Created by 경원이 on 2021/10/24.
//

import UIKit
import MapKit
import CloudKit
import CoreLocation
import CoreLocationUI

class MapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    var alt: Double = 0
    var lag: Double = 0
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

}

extension MapViewController: MKMapViewDelegate {
    
}

extension MapViewController: CLLocationManagerDelegate {
    
}


