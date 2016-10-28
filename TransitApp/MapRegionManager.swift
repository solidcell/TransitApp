import MapKit

class MapRegionManager {

    private let regionRadius: CLLocationDistance = 10000
    private let fallbackInitialCoordinate = CLLocationCoordinate2D(latitude: 52.5302356,
                                                                   longitude: 13.4033659)

    func region(annotations: [MapAnnotation]) -> MKCoordinateRegion {
        let coordinate = firstCoordinate(annotations: annotations)

        return MKCoordinateRegionMakeWithDistance(coordinate,
                                                  regionRadius * 2.0, regionRadius * 2.0)
    }

    private func firstCoordinate(annotations: [MapAnnotation]) -> CLLocationCoordinate2D {
        return annotations.first?.coordinate ?? self.fallbackInitialCoordinate
    }

}
