import RealmSwift
import MapKit

class MapAnnotationProvider {

    private let mapAnnotationCreator = MapAnnotationCreator()
    private let realm: Realm

    init(realm: Realm) {
        self.realm = realm
    }

    lazy var annotations: [MKAnnotation] = {
        let scooters = self.realm.scooters
        return self.mapAnnotationCreator.annotations(scooters: scooters)
    }()

}
