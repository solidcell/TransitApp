import RealmSwift
import MapKit

class MapAnnotationCreator {

    let door2DoorMapAnnotationCreator = Door2DoorMapAnnotationCreator()
    let coupMapAnnotationCreator = CoupMapAnnotationCreator()

    func annotations(stops: Results<Stop>) -> [MapAnnotation] {
        return door2DoorMapAnnotationCreator.annotations(stops: stops)
    }

    func annotations(scooters: Results<Scooter>) -> [MapAnnotation] {
        return coupMapAnnotationCreator.annotations(scooters: scooters)
    }
    
}
