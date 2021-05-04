//
//  AddLocationVC.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 02/05/21.
//

import UIKit
import MapKit

protocol AddLocationVCDelegate {
    func didSelect(location: String)
}

class AddLocationVC: BaseViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var selectedLocation: String?
    var delegate: AddLocationVCDelegate?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(singleTapAction))
        mapView.addGestureRecognizer(singleTapGesture)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.btnDoneTapped))
        self.navigationItem.rightBarButtonItem = doneButton
        
        getCurrentLocation()
    }
    
    @objc private func btnDoneTapped() {
        guard let location = selectedLocation,
              !location.isEmpty,
              let delegate = delegate else { return }
        
        delegate.didSelect(location: location)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func singleTapAction(sender: UIGestureRecognizer) {
        let locationInView = sender.location(in: mapView)
        let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
        
//        Logger.printMessage(message: "\(locationOnMap)", request: "LAT, LONG")
        
        addAnnotation(location: locationOnMap)
        
        getPlace(from: locationOnMap, completion: { [weak self] (locationName) in
            guard let self = self else { return }
            self.selectedLocation = locationName
        })
    }
    
    private func addAnnotation(location: CLLocationCoordinate2D) {
        mapView.removeAnnotations(mapView.annotations)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
//        annotation.title = "title"
//        annotation.subtitle = "subtitle"
        mapView.addAnnotation(annotation)
    }
    
    private func getCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    private func getPlace(from location: CLLocationCoordinate2D, completion: @escaping ((_ locationName: String) -> Void)) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: location.latitude, longitude: location.longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            let placeName = placeMark.name ?? ""
//            Logger.printMessage(message: name, request: "LOCATION:")
            completion(placeName)
        })
    }
}

extension AddLocationVC: CLLocationManagerDelegate {
//    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//            locationManager.requestLocation()
//        }
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("location:: \(location)")
            
            addAnnotation(location: location.coordinate)
            mapView.showsUserLocation = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
}

extension AddLocationVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let reuseIdentifier = "LocationPin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKPinAnnotationView 
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
//            pinView?.canShowCallout = true
//            pinView?.rightCalloutAccessoryView = UIButton(type: .infoDark)
//            pinView?.pinTintColor = UIColor.black
        } else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        if control == view.rightCalloutAccessoryView {
//            if let doSomething = view.annotation?.title {
//                print("Accessory View Selected")
//            }
//        }
//    }
}
