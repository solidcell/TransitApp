import MapKit

class CoupMapAnnotationViewCreator {
    
    private static let reuseIdentifier = "CoupAnnotationViewReuseIdentifier"
    
    func view(mapView: MKMapView, annotation: CoupMapAnnotation) -> MKAnnotationView {
        let view = unconfiguredView(mapView: mapView, annotation: annotation)
        view.configure(annotation: annotation)
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

private extension MKPinAnnotationView {

    func configure(annotation: CoupMapAnnotation) {
        let color: UIColor
        switch annotation.energyLevel {
        case 0...30:
            color = UIColor.red
        case 31...50:
            color = UIColor.yellow
        case 51...100:
            color = UIColor.green
        default:
            fatalError()
        }
        pinTintColor = color
    }
    
}
