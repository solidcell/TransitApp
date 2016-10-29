import RealmSwift
import MapKit

class MapAnnotationCreator {

    let door2DoorMapAnnotationCreator = Door2DoorMapAnnotationCreator()
    let coupMapAnnotationCreator = CoupMapAnnotationCreator()

    func annotations(stops: Results<Stop>) -> [Door2DoorMapAnnotation] {
        return door2DoorMapAnnotationCreator.annotations(stops: stops)
    }

    func annotations(scooters: Results<Scooter>) -> [CoupMapAnnotation] {
        return coupMapAnnotationCreator.annotations(scooters: scooters)
    }
    
}
