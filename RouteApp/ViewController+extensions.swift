//
//  ViewController+extensions.swift
//  RouteApp
//
//  Created by Artem Tkachev on 26.10.23.
//

import Foundation
import MapKit

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .red
        return renderer
    }
}

extension ViewController {
    
    func setConstraints() {
        
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        mapView.addSubview(addPointButton)
        NSLayoutConstraint.activate([
            addPointButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 50),
            addPointButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            addPointButton.widthAnchor.constraint(equalToConstant: 100),
            addPointButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        mapView.addSubview(buildRouteButton)
        NSLayoutConstraint.activate([
            buildRouteButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -50),
            buildRouteButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20),
            buildRouteButton.widthAnchor.constraint(equalToConstant: 100),
            buildRouteButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        mapView.addSubview(resetButton)
        NSLayoutConstraint.activate([
            resetButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -50),
            resetButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            resetButton.widthAnchor.constraint(equalToConstant: 100),
            resetButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
}
