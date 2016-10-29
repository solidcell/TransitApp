import MapKit

class CoupMapAnnotationViewCreator {
    
    static let reuseIdentifier = "CoupAnnotationViewReuseIdentifier"
    
    func view(mapView: MKMapView, annotation: CoupMapAnnotation) -> MKAnnotationView {
        let view = unconfiguredView(mapView: mapView, annotation: annotation)
        view.pinTintColor = UIColor.green
        return view
    }

    private func unconfiguredView(mapView: MKMapView, annotation: MKAnnotation?) -> MKPinAnnotationView {
        return CoupMapAnnotationViewCreator.dequeueView(mapView: mapView, annotation: annotation) ??
            CoupMapAnnotationViewCreator.createNewView(annotation: annotation)
    }

    class private func dequeueView(mapView: MKMapView, annotation: MKAnnotation?) -> MKPinAnnotationView? {
        return mapView.dequeueReusableAnnotationView(withIdentifier: CoupMapAnnotationViewCreator.reuseIdentifier) as? MKPinAnnotationView
    }

    class private func createNewView(annotation: MKAnnotation?) -> MKPinAnnotationView {
        return MKPinAnnotationView(annotation: annotation,
                                   reuseIdentifier: reuseIdentifier)
    }
    
}
