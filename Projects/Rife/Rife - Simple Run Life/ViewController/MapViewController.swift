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
import CloudKit
import RealmSwift


class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    let localRealm = try! Realm()
    
    var currentOverlay: MKPolyline = MKPolyline()
    let locationManager: CLLocationManager = CLLocationManager()
    var previousCoordinate: CLLocationCoordinate2D?
    var points: [CLLocationCoordinate2D] = []
    
    var runMode:RunMode = .ready
    var recordImage: UIImage = UIImage()
    let fileManager = FileManager()
    var totalDistance: CLLocationDistance = CLLocationDistance()
    var startTime: Date = Date()
    var endTime: Date = Date()
    var totalRunTime: String = ""
    
    
    
    
    
    @IBOutlet var recordView: UIImageView!
    @IBOutlet var mapKit: MKMapView!
    @IBOutlet var resultDistanceLabel: UILabel!
    @IBOutlet var resultTimeLabel: UILabel!
    @IBOutlet var runButton: UIButton!
    @IBOutlet var navigationBar: UIView!
    
    
    
    
    func generateMapImage() {
        let options = MKMapSnapshotter.Options()
        options.region = MKCoordinateRegion(coordinates: self.points)!
        options.size = CGSize(width: 100, height: 100)
        options.showsBuildings = true
        
        MKMapSnapshotter(options: options).start { snapshot, error in
            guard let snapshot = snapshot else { return }
            
            let mapImage = snapshot.image
            
            let finalImage = UIGraphicsImageRenderer(size: mapImage.size).image { _ in
                mapImage.draw(at: .zero)
                
               let coordinates = self.points
                
                let points2 = coordinates.map { coordinate in
                    snapshot.point(for: coordinate)
                }
                
                let path = UIBezierPath()
                path.move(to: points2[0])
                
                for point in points2.dropFirst() {
                    path.addLine(to: point)
                }
                path.lineWidth = 7
                UIColor.red.setStroke()
                path.stroke()
            }
            
            self.recordImage = finalImage
        }
        
    }
    
    
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
        
       
        let point1 = CLLocationCoordinate2DMake(self.previousCoordinate?.latitude ?? location.coordinate.latitude, self.previousCoordinate?.longitude ?? location.coordinate.longitude)
            let point2: CLLocationCoordinate2D
            = CLLocationCoordinate2DMake(latitude, longtitude)
            self.points.append(point1)
            self.points.append(point2)
            
        let loc1 = CLLocation(latitude: self.previousCoordinate?.latitude ?? 0.0, longitude: self.previousCoordinate?.longitude ?? 0.0)
        let loc2 = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let addedDistance = loc1.distance(from: loc2)
        
        self.totalDistance += addedDistance
        
        
    
            
            let lineDraw = MKPolyline(coordinates: points, count:points.count)
            self.mapKit.addOverlay(lineDraw)
    
        
       
        

           
        
        
        self.previousCoordinate = location.coordinate
        print("Im still updating")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        navigationBar.layer.borderWidth = 1
        navigationBar.layer.borderColor = UIColor(named: "black")?.cgColor
        
        resultDistanceLabel.attributedText = outline(string: "11.25km", font: "NotoSansKR-Black", size: 40, outlineSize: 3, textColor: UIColor(red: 0.4941, green: 0.9922, blue: 0.6941, alpha: 1.0), outlineColor: .black)
        resultTimeLabel.attributedText = outline(string: "1:00:25", font: "NotoSansKR-Black", size: 40, outlineSize: 3, textColor: UIColor(red: 0.4941, green: 0.9922, blue: 0.6941, alpha: 1.0), outlineColor: .black)
        
        resultDistanceLabel.isHidden = true
        resultTimeLabel.isHidden = true
        
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        
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
            points = []
            self.totalDistance = CLLocationDistance()
            
            
            self.previousCoordinate = locationManager.location?.coordinate

            locationManager.startUpdatingLocation()
            self.points = []
            self.mapKit.showsUserLocation = true
            self.mapKit.setUserTrackingMode(.follow, animated: true)
            runButton.setImage(UIImage(named: "Stop"), for: .normal)
            self.runMode = .running
            resultDistanceLabel.isHidden = true
            resultTimeLabel.isHidden = true
            self.startTime = Date()
            
        } else if runMode == .running {
            locationManager.stopUpdatingLocation()
            self.mapKit.showsUserLocation = false
            self.mapKit.setUserTrackingMode(.none, animated: true)
            runButton.setImage(UIImage(named: "Save"), for: .normal)
            self.runMode = .finished
            resultDistanceLabel.isHidden = false
            let distanceFormatter = MKDistanceFormatter()
            distanceFormatter.units = .metric
            let stringDistance = distanceFormatter.string(fromDistance: totalDistance)
            resultDistanceLabel.text = stringDistance
            resultTimeLabel.isHidden = false
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            generateMapImage()
            self.endTime = Date()
            
            
            var runTime = self.endTime.timeIntervalSince(self.startTime)
            let formatter = DateComponentsFormatter()
            let stringRunTime = formatter.string(from: runTime)!
            
            self.totalRunTime = stringRunTime
            
            resultTimeLabel.text = stringRunTime
            
            

        } else if runMode == .finished {
            // is when user tapped Save button
            self.mapKit.setUserTrackingMode(.follow, animated: true)
            
            print(recordImage)
            
            let data: Data = recordImage.jpegData(compressionQuality: 0.8)!
            let task = RecordObject(image: data, distance: self.totalDistance, time: self.totalRunTime)
            try! localRealm.write {
                localRealm.add(task)
            }
            let overlays = mapKit.overlays
            mapKit.removeOverlays(overlays)
            runButton.setImage(UIImage(named: "Start"), for: .normal)
            self.runMode = .ready
            resultDistanceLabel.isHidden = true
            resultTimeLabel.isHidden = true
            self.mapKit.showsUserLocation = true
            
            
            
            
            
            
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
