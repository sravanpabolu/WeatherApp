//
//  AddLocationVC.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 02/05/21.
//

import UIKit
import MapKit

protocol AddLocationVCDelegate {
    func didSelect(location: BookmarkedLocation)
}

class AddLocationVC: BaseViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var selectedLocation: BookmarkedLocation?
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
              let delegate = delegate else { return }
        
        delegate.didSelect(location: location)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func singleTapAction(sender: UIGestureRecognizer) {
        let locationInView = sender.location(in: mapView)
        let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
        
        Queue.main { [weak self] in
            guard let self = self else { return }
            self.addAnnotation(location: locationOnMap)
        }
        
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
    
    private func getPlace(from location: CLLocationCoordinate2D, completion: @escaping ((_ locationName: BookmarkedLocation?) -> Void)) {
        let geoCoder = CLGeocoder()
        let geoLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        
        geoCoder.reverseGeocodeLocation(geoLocation) { (placemarks, error) in
            if error != nil {
                completion(nil)
                return
            }
            
            if let placeMark = placemarks?.first {
                var place = BookmarkedLocation()
                place.name = placeMark.name
                place.locality = placeMark.locality
                place.adminArea = placeMark.administrativeArea
                place.subLocality = placeMark.subLocality
                place.lat = placeMark.location?.coordinate.latitude
                place.long = placeMark.location?.coordinate.longitude
                
                completion(place)
            }
        }
    }
}

extension AddLocationVC: CLLocationManagerDelegate {
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
            pinView?.pinTintColor = UIColor.blue
        } else {
            pinView?.annotation = annotation
        }
        return pinView
    }
}
