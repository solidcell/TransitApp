import MapKit

class MapViewDelegate: NSObject, MKMapViewDelegate {

    let coupMapAnnotationViewCreator = CoupMapAnnotationViewCreator()
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let coupAnnotation = annotation as! CoupMapAnnotation
        return coupMapAnnotationViewCreator.view(mapView: mapView, annotation: coupAnnotation)
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polygon = MKPolygonRenderer(overlay: overlay)
        polygon.strokeColor = UIColor(rgb: 0x7DD5DE)
        polygon.lineWidth = 2
        polygon.fillColor = UIColor(rgb: 0x2B354A, alpha: 0.09)
        return polygon
    }

}
