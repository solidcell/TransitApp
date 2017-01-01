import MapKit

class MapViewDelegate: NSObject, MKMapViewDelegate {

    let coupMapAnnotationViewCreator = CoupMapAnnotationViewCreator()
    weak var userTrackingModeDelegate: UserTrackingModeDelegate?

    init(userTrackingModeDelegate: UserTrackingModeDelegate) {
        self.userTrackingModeDelegate = userTrackingModeDelegate
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let coupAnnotation = annotation as? CoupMapAnnotation {
            return coupMapAnnotationViewCreator.view(mapView: mapView, annotation: coupAnnotation)
        }
        return nil
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polygon = MKPolygonRenderer(overlay: overlay)
        polygon.strokeColor = UIColor(rgb: 0x7DD5DE)
        polygon.lineWidth = 2
        polygon.fillColor = UIColor(rgb: 0x2B354A, alpha: 0.09)
        return polygon
    }

    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
        userTrackingModeDelegate!.didChangeMode(mode)
    }

}

protocol UserTrackingModeDelegate : class {

    func didChangeMode(_ mode: MKUserTrackingMode)
    
}
