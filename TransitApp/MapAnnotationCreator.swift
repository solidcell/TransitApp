import RealmSwift
import MapKit

class MapAnnotationCreator {

    let door2DoorMapAnnotationCreator = Door2DoorMapAnnotationCreator()

    func annotations(stops: Results<Stop>) -> [MapAnnotation] {
        return door2DoorMapAnnotationCreator.annotations(stops: stops)
    }
    
}
