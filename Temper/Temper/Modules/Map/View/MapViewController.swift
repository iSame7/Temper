//
//  MapViewController.swift
//  Temper
//
//  Created by Sameh Mabrouk on 20/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var presenter: MapPresentable!
    var jobs = [Job]()
    var venuePhotos : [String: String] = [:]
    var indexOfCellBeforeDragging = 0
    var scrollToItem = true
    var selectedItemIndex: Int = 0 {
        didSet {
            selectAnnotation(atIndext: selectedItemIndex)
        }
    }
    
    private var annotationsForVenues = [JobAnnotation]()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
        presenter.getJobs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configureCollectionViewLayoutItemSize()
    }
}

// MARK: - MapViewable
extension MapViewController: MapViewable {
    func updateUserLocation(_ locationViewModel: MapViewController.LocationViewModel) {
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let coordinates = CLLocationCoordinate2D(latitude: locationViewModel.lat, longitude: locationViewModel.lng)
        let viewRegion = MKCoordinateRegion(center: coordinates, span: span)
        mapView.setRegion(viewRegion, animated: true)
    }
    
    func showError(error: TemperError) {
        if let errorDescription = error.errorDescription, let errorTitle = error.errorUserInfo[NSLocalizedDescriptionKey] as? String {
            InAppNotifications.showNotification(type: InAppNotifications.error, title: errorTitle, message: errorDescription, dismissDelay: 3)
        }
    }
    
    func update(_ model: [Job]) {
        jobs = model
        addAnnotationsToMap(jobs: model)
        collectionView.reloadData()
    }
    
    private func addAnnotationsToMap(jobs: [Job]){
        mapView.delegate = self
        DispatchQueue.main.async {
            self.mapView.addAnnotations(self.presenter.annotationsForJobs())
        }
    }
}

// MARK: MapView Delegate
extension MapViewController : MKMapViewDelegate {
    //view for each annotation
    internal func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //this keeps the user location point as a default blue dot.
        if annotation is MKUserLocation { return nil }
        
        //setup annotation view for map - we can fully customize the marker
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "JobAnnotationView") as? MKMarkerAnnotationView
        
        //setup annotation view
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "JobAnnotationView")
            annotationView?.canShowCallout = false
            annotationView?.animatesWhenAdded = true
            annotationView?.markerTintColor = .marker
            annotationView?.isHighlighted = true
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    //callout tapped/selected
    internal func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
    }
    
    
    // didSelect - setting currentSelected Venue
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if scrollToItem {
            if let venueAnnotation = view.annotation as? JobAnnotation {
                let selectedVenueIndex = jobs.firstIndex(where: { $0.title == venueAnnotation.title })
                let indexPath = IndexPath(row: selectedVenueIndex ?? 0, section: 0)
                collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }
    }
    
    func selectAnnotation(atIndext index: Int) {
        scrollToItem = false
        if let annotation = (mapView.annotations.first { (annotation) -> Bool in
            let venueAnnotation = annotation as? JobAnnotation
            return venueAnnotation?.subtitle == presenter.itemAt(index: index).client.name
        }) {
            mapView.selectAnnotation(annotation, animated: true)
            scrollToItem = true
            
            let venueAnnotation = annotation as? JobAnnotation
            let selectedJob = jobs.first(where: { $0.title == venueAnnotation?.title })
            
            if let selectedJob = selectedJob {
                if let locationLat = selectedJob.location.lat, let locationLng = selectedJob.location.lng {
                    let selectedVenueLocation = CLLocation(latitude: CLLocationDegrees(Double(locationLat)!), longitude: CLLocationDegrees(Double(locationLng)!))
                    // only move to another region if the selected venue's location in not in the current map region
                    if !regionContains(region: mapView.region, location: selectedVenueLocation) {
                        let coordinates = CLLocationCoordinate2D(latitude: Double(locationLat)!, longitude: Double(locationLng)!)
                        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                        let viewRegion = MKCoordinateRegion(center: coordinates, span: span)
                        mapView.setRegion(viewRegion, animated: true)
                    }
                }
                
            }
        }
    }
    
    /* Standardises and angle to [-180 to 180] degrees */
    func standardAngle( angle: inout CLLocationDegrees) -> CLLocationDegrees {
        angle = angle.truncatingRemainder(dividingBy: 360)
        return angle < -180 ? -360 - angle : angle > 180 ? 360 - 180 : angle
    }
    
    /* confirms that a region contains a location */
    func regionContains(region: MKCoordinateRegion, location: CLLocation) -> Bool {
        var latitudeAngleDiff = region.center.latitude - location.coordinate.latitude
        let deltaLat = abs(standardAngle(angle: &latitudeAngleDiff))
        var longitudeAngleDiff = region.center.longitude - location.coordinate.longitude
        let deltalong = abs(standardAngle(angle:&longitudeAngleDiff))
        return region.span.latitudeDelta >= deltaLat && region.span.longitudeDelta >= deltalong
    }
}

// MARK: - StoryboardInstantiatable
extension MapViewController: StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType {
        return .identifier("MapViewController")
    }
    
    static var storyboardName: String {
        return StoryboardName.jobs.rawValue
    }
}

// MARK: - ViewModel
extension MapViewController {
    struct LocationViewModel {
        let lat: Double
        let lng: Double
    }
}
