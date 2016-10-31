import RealmSwift
import MapKit

class MapAnnotationProvider {

    private let mapAnnotationCreator = MapAnnotationCreator()
    private let realm: Realm
    private let mapSourceManager: MapSourceManager

    init(realm: Realm, mapSourceManager: MapSourceManager) {
        self.realm = realm
        self.mapSourceManager = mapSourceManager
    }

    var annotations: [MKAnnotation] {
        switch mapSourceManager.source {
        case .coup:
            let scooters = realm.scooters
            return mapAnnotationCreator.annotations(scooters: scooters)
        case .door2door:
            let stops = realm.stops
            return mapAnnotationCreator.annotations(stops: stops)
        }
    }

}
