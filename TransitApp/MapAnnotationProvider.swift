import RealmSwift
import MapKit

class MapAnnotationProvider {

    private let mapAnnotationCreator = MapAnnotationCreator()
    private let realm: Realm
    private let source: MapSourceManager.Source

    init(realm: Realm, source: MapSourceManager.Source) {
        self.realm = realm
        self.source = source
    }

    lazy var annotations: [MKAnnotation] = {
        switch self.source {
        case .coup:
            let scooters = self.realm.scooters
            return self.mapAnnotationCreator.annotations(scooters: scooters)
        case .door2door:
            let stops = self.realm.stops
            return self.mapAnnotationCreator.annotations(stops: stops)
        }
    }()

}
