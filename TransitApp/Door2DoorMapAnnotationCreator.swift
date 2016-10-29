import RealmSwift
import MapKit

class Door2DoorMapAnnotationCreator {

    func annotations(stops: Results<Stop>) -> [MapAnnotation] {
        return stops.map(stopToAnnotation)
    }

    private func stopToAnnotation(stop: Stop) -> MapAnnotation {
        return MapAnnotation(title: stop.name,
                             locationName: stop.name,
                             discipline: stop.name,
                             coordinate: CLLocationCoordinate2D(latitude: stop.latitude,
                                                                longitude: stop.longitude))
    }
    
}
