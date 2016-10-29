import RealmSwift
import MapKit

class Door2DoorMapAnnotationCreator {

    func annotations(stops: Results<Stop>) -> [Door2DoorMapAnnotation] {
        return stops.map(stopToAnnotation)
    }

    private func stopToAnnotation(stop: Stop) -> Door2DoorMapAnnotation {
        return Door2DoorMapAnnotation(title: stop.name,
                                      locationName: stop.name,
                                      discipline: stop.name,
                                      coordinate: CLLocationCoordinate2D(latitude: stop.latitude,
                                                                         longitude: stop.longitude))
    }
    
}
