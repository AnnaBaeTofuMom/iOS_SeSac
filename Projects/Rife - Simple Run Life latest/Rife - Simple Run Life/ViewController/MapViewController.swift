//
//  MapViewController.swift
//  Rife - Simple Run Life
//
//  Created by 배경원 on 2021/11/17.
//

import UIKit
import SideMenu
import MarqueeLabel
import XCTest
import MapKit
import CoreLocation
import RealmSwift

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var currentOverlay: MKPolyline = MKPolyline()
    let locationManager: CLLocationManager = CLLocationManager()
    var previousCoordinate: CLLocationCoordinate2D?
    
    var runMode:RunMode = .ready
    
    @IBOutlet var mapKit: MKMapView!
    @IBOutlet var resultDistanceLabel: UILabel!
    @IBOutlet var resultTimeLabel: UILabel!
    @IBOutlet var runButton: UIButton!
    @IBOutlet var navigationBar: UIView!
    
    func outline(string:String, font:String, size:CGFloat, outlineSize:Float, textColor:UIColor, outlineColor:UIColor) -> NSMutableAttributedString {
        return NSMutableAttributedString(string:string,
                                         attributes: outlineAttributes(font: UIFont(name: font, size: size)!,
                                                            outlineSize: outlineSize, textColor: textColor, outlineColor: outlineColor))
    }

    func outlineAttributes(font: UIFont, outlineSize: Float, textColor: UIColor, outlineColor: UIColor) -> [NSAttributedString.Key: Any]{
        return [
            NSAttributedString.Key.strokeColor : outlineColor,
            NSAttributedString.Key.foregroundColor : textColor,
            NSAttributedString.Key.strokeWidth : -outlineSize,
            NSAttributedString.Key.font : font
        ]
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

            guard let location = locations.last
            else {return}
            let latitude = location.coordinate.latitude
            let longtitude = location.coordinate.longitude
        
        if let previousCoordinate = self.previousCoordinate {
            var points: [CLLocationCoordinate2D] = []
            let point1 = CLLocationCoordinate2DMake(previousCoordinate.latitude, previousCoordinate.longitude)
            let point2: CLLocationCoordinate2D
            = CLLocationCoordinate2DMake(latitude, longtitude)
            points.append(point1)
            points.append(point2)
            let lineDraw = MKPolyline(coordinates: points, count:points.count)
            self.mapKit.addOverlay(lineDraw)
        
       
        

           
        }
        
        self.previousCoordinate = location.coordinate
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        navigationBar.layer.borderWidth = 1
        navigationBar.layer.borderColor = UIColor(named: "black")?.cgColor
        
        resultDistanceLabel.attributedText = outline(string: "11.25km", font: "NotoSansKR-Black", size: 40, outlineSize: 3, textColor: UIColor(red: 0.4941, green: 0.9922, blue: 0.6941, alpha: 1.0), outlineColor: .black)
        resultTimeLabel.attributedText = outline(string: "1:00:25", font: "NotoSansKR-Black", size: 40, outlineSize: 3, textColor: UIColor(red: 0.4941, green: 0.9922, blue: 0.6941, alpha: 1.0), outlineColor: .black)
        
        resultDistanceLabel.isHidden = true
        resultTimeLabel.isHidden = true
        
        locationManager.requestWhenInUseAuthorization()
        
        self.mapKit.mapType = MKMapType.standard
        self.mapKit.showsUserLocation = true
        self.mapKit.setUserTrackingMode(.follow, animated: true)
        self.mapKit.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.startUpdatingLocation()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("mapView appear")
    }
    


    @IBAction func sideBarButtonClicked(_ sender: UIButton) {
        print("sidemenu opened")
    }
    
    @IBAction func runButtonClicked(_ sender: UIButton) {
        if runMode == .ready {
            locationManager.startUpdatingLocation()
            self.mapKit.showsUserLocation = true
            self.mapKit.setUserTrackingMode(.follow, animated: true)
            runButton.setImage(UIImage(named: "Stop"), for: .normal)
            self.runMode = .running
            resultDistanceLabel.isHidden = true
            resultTimeLabel.isHidden = true
        } else if runMode == .running {
            locationManager.stopUpdatingLocation()
            self.mapKit.showsUserLocation = false
            self.mapKit.setUserTrackingMode(.none, animated: true)
            runButton.setImage(UIImage(named: "Save"), for: .normal)
            self.runMode = .finished
            resultDistanceLabel.isHidden = false
            resultTimeLabel.isHidden = false
        } else if runMode == .finished {
            let overlays = mapKit.overlays
            mapKit.removeOverlays(overlays)
            runButton.setImage(UIImage(named: "Start"), for: .normal)
            self.runMode = .ready
            resultDistanceLabel.isHidden = true
            resultTimeLabel.isHidden = true
        } else {
            
        }
    }

}

//Polyline 의 모양을 컨트롤 해 주는 부분
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyLine = overlay as? MKPolyline
        else {
            print("can't draw polyline")
            return MKOverlayRenderer()
        }
        let renderer = MKPolylineRenderer(polyline: polyLine)
            renderer.strokeColor = .red
            renderer.lineWidth = 10.0
            renderer.alpha = 1.0

        return renderer
    }
}
