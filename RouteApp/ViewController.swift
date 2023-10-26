//
//  ViewController.swift
//  RouteApp
//
//  Created by Artem Tkachev on 24.10.23.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    let addPointButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add point", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let buildRouteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Build route", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var annotationsArray = [MKPointAnnotation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        setConstraints()
        
        addPointButton.addTarget(self, action: #selector(addPoint), for: .touchUpInside)
        buildRouteButton.addTarget(self, action: #selector(buildRoute), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetPoints), for: .touchUpInside)
        
    }
    
    @objc func addPoint() {
        alertAddAdress(title: "Add point", placeholder: "Enter point address") { [self] text in
            setupPlacemark(addressPlace: text)
        }
    }
    
    @objc func buildRoute() {
        
        if annotationsArray.count > 2 {
            for index in 0...annotationsArray.count - 2 {
                
                createRouteRequest(startCoordinate: annotationsArray[index].coordinate, destinationCoordinate: annotationsArray[index + 1].coordinate)
            }
        } else {
            createRouteRequest(startCoordinate: annotationsArray[0].coordinate, destinationCoordinate: annotationsArray[1].coordinate)
        }
        
        mapView.showAnnotations(annotationsArray, animated: true)
        
    }
    
    @objc func resetPoints() {
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        annotationsArray.removeAll()
        buildRouteButton.isHidden = true
        resetButton.isHidden = true
    }
    
    private func setupPlacemark(addressPlace: String) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressPlace) { [self] (placemarks, error) in
            
            if let error = error {
                allert(title: "Error", message: "Wrong address")
                return
            }
            
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = "\(addressPlace)"
            guard let placemarkLocation = placemark?.location else { return }
            annotation.coordinate = placemarkLocation.coordinate
            
            annotationsArray.append(annotation)
            
            if annotationsArray.count > 1 {
                buildRouteButton.isHidden = false
                resetButton.isHidden = false
            }
            
            mapView.showAnnotations(annotationsArray, animated: true)
        }
    }
    
    private func createRouteRequest(startCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        
        let startPoint = MKPlacemark(coordinate: startCoordinate)
        let destinationPoint = MKPlacemark(coordinate: destinationCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startPoint)
        request.destination = MKMapItem(placemark: destinationPoint)
        request.transportType = .walking
        request.requestsAlternateRoutes = true
        
        let direction = MKDirections(request: request)
        direction.calculate { (responce, error) in
            
            if let error = error {
                print (error)
                return
            }
            
            guard let responce = responce else {
                self.allert(title: "Error", message: "Route unavailable")
                return
            }
            
            var minRoute = responce.routes[0]
            for route in responce.routes {
                minRoute = (route.distance < minRoute.distance) ? route : minRoute
            }
            
            self.mapView.addOverlay(minRoute.polyline)
        }
    }


}



