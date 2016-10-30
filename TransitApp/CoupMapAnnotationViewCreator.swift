import MapKit

class CoupMapAnnotationViewCreator {
    
    private static let reuseIdentifier = "CoupAnnotationViewReuseIdentifier"
    
    func view(mapView: MKMapView, annotation: CoupMapAnnotation) -> MKAnnotationView {
        let view = unconfiguredView(mapView: mapView, annotation: annotation)
        view.configure(annotation: annotation)
        return view
    }

    private func unconfiguredView(mapView: MKMapView, annotation: MKAnnotation?) -> CoupMapAnnotationView {
        return CoupMapAnnotationViewCreator.dequeueView(mapView: mapView) ??
            CoupMapAnnotationViewCreator.createNewView(annotation: annotation)
    }

    class private func dequeueView(mapView: MKMapView) -> CoupMapAnnotationView? {
        return mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? CoupMapAnnotationView
    }

    class private func createNewView(annotation: MKAnnotation?) -> CoupMapAnnotationView {
        return CoupMapAnnotationView(annotation: annotation,
                                     reuseIdentifier: reuseIdentifier)
    }
    
}
