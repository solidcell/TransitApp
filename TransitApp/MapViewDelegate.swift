import MapKit

class MapViewDelegate: NSObject, MKMapViewDelegate {

    let coupMapAnnotationViewCreator = CoupMapAnnotationViewCreator()
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let coupAnnotation = annotation as? CoupMapAnnotation {
            return coupMapAnnotationViewCreator.view(mapView: mapView, annotation: coupAnnotation)
        }
        return nil
    }

}
