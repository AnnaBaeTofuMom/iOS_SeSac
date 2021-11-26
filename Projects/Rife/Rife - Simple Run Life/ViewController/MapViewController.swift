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
import Kingfisher
import SwiftyJSON
import Alamofire


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
    var totalRunTime: String = ""
    
    var timer = Timer()
    var (hours, minutes, seconds, fractions) = (0, 0, 0, 0)
    var currentWeather: String = ""
    var finalData: Data = Data()
    
    
    
    
    @IBOutlet var weatherIconView: UIImageView!
    @IBOutlet var recordView: UIImageView!
    @IBOutlet var mapKit: MKMapView!
    @IBOutlet var resultDistanceLabel: UILabel!
    @IBOutlet var resultTimeLabel: UILabel!
    @IBOutlet var runButton: UIButton!
    @IBOutlet var navigationBar: UIView!
    
    
    func fetchWeatherData() -> Void {
            guard let currentLocation = locationManager.location else { return }
            let lati = currentLocation.coordinate.latitude
            let longi = currentLocation.coordinate.longitude
                    let key = "e48c83dbb4739468d69bb4e998f8939d"
                    let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(lati)&lon=\(longi)&appid=\(key)"
                    
            AF.request(url, method: .get).validate().responseJSON { response in
                switch response.result{
                case .success: guard let result = response.data else { return }
                    let json = JSON(result)
                    for item in json["weather"].arrayValue {
                        self.currentWeather = item["main"].stringValue
                        let icon = item["icon"].stringValue
                        let url = URL(string: "http://openweathermap.org/img/wn/\(icon)@2x.png")
                        self.weatherIconView.kf.setImage(with: url)
                        print("********success************")
                
                    }
                case .failure(let error):
                    print("***************This is error**************",error)
                    
                    
                }
            }
            
        }
    
    
    func generateMapImage() {
        let options = MKMapSnapshotter.Options()
        options.region = MKCoordinateRegion(coordinates: self.points)!
        options.size = CGSize(width: 240, height: 240)
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
                UIColor(hue: 0.6694, saturation: 1, brightness: 0.91, alpha: 1.0).setStroke()
                path.stroke()
            }
            
            self.recordImage = finalImage
        }
        
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
        let distanceFormatter = MKDistanceFormatter()
        distanceFormatter.units = .metric
        let addedDistance = loc1.distance(from: loc2)
        
        
        self.totalDistance += addedDistance
        
        let stringDistance = distanceFormatter.string(fromDistance: totalDistance)
        self.resultDistanceLabel.text = "\(stringDistance)"

        
        
    
            
            let lineDraw = MKPolyline(coordinates: points, count:points.count)
            self.mapKit.addOverlay(lineDraw)
    
        
       
        

           
        
        
        self.previousCoordinate = location.coordinate
        print("Im still updating")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        weatherIconView.layer.cornerRadius = weatherIconView.frame.width / 2
        weatherIconView.layer.borderColor = UIColor(named: "black")?.cgColor
        weatherIconView.layer.borderWidth = 1
        fetchWeatherData()
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        
        self.mapKit.mapType = MKMapType.standard
        self.mapKit.showsUserLocation = true
        self.mapKit.setUserTrackingMode(.follow, animated: true)
        
        self.mapKit.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        
        
        navigationBar.layer.borderWidth = 1
        navigationBar.layer.borderColor = UIColor(named: "black")?.cgColor
        
        resultDistanceLabel.attributedText = outline(string: "11.25km", font: "NotoSansKR-Black", size: 40, outlineSize: 3, textColor: UIColor(red: 0.4941, green: 0.9922, blue: 0.6941, alpha: 1.0), outlineColor: .black)
        resultTimeLabel.attributedText = outline(string: "1:00:25", font: "NotoSansKR-Black", size: 40, outlineSize: 3, textColor: UIColor(red: 0.4941, green: 0.9922, blue: 0.6941, alpha: 1.0), outlineColor: .black)
        
        resultDistanceLabel.isHidden = true
        resultTimeLabel.isHidden = true
        
        
        //locationManager.startUpdatingLocation()
        
        
    }
    
    


    @IBAction func sideBarButtonClicked(_ sender: UIButton) {
    }
    
    
    @objc func keepTimer() {
        fractions += 1
        if fractions > 99 {
            seconds += 1
            fractions = 0
        }
        
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        if minutes == 60 {
            hours += 1
            minutes = 0
        }
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        let hoursString = hours > 9 ? "\(hours)" : "0\(hours)"
        
        totalRunTime = "\(hoursString):\(minutesString):\(secondsString)"
        resultTimeLabel.text = self.totalRunTime
        
    }
    
    @IBAction func runButtonClicked(_ sender: UIButton) {
        if runMode == .ready {
            fetchWeatherData()
            resultTimeLabel.text = self.totalRunTime
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(MapViewController.keepTimer), userInfo: nil, repeats: true)
            points = []
            self.totalDistance = CLLocationDistance()
            
            
            self.previousCoordinate = locationManager.location?.coordinate

            locationManager.startUpdatingLocation()
            self.points = []
            self.mapKit.showsUserLocation = true
            self.mapKit.setUserTrackingMode(.follow, animated: true)
            runButton.setImage(UIImage(named: "Stop"), for: .normal)
            self.runMode = .running
            resultDistanceLabel.isHidden = false
            resultTimeLabel.isHidden = false
            
            
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
            generateMapImage()
            timer.invalidate()
            
            
            
            resultTimeLabel.text = self.totalRunTime
            
            

        } else if runMode == .finished {
            timer.invalidate()
            (hours, minutes, seconds, fractions) = (0, 0, 0, 0)
            resultTimeLabel.text = totalRunTime
            // is when user tapped Save button
            self.mapKit.setUserTrackingMode(.follow, animated: true)
            
            print(recordImage)
            
//            let data: Data = recordImage.jpegData(compressionQuality: 0.1)!
            finalData = recordImage.jpegData(compressionQuality: 0.1)!
            let task = RecordObject(image: self.finalData, distance: self.totalDistance, time: self.totalRunTime)
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
            renderer.strokeColor = UIColor(hue: 0.6694, saturation: 1, brightness: 0.91, alpha: 1.0)
            renderer.lineWidth = 10.0
            renderer.alpha = 1.0

        return renderer
    }
}

