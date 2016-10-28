import RealmSwift

class MapAnnotationProvider {

    private let mapAnnotationCreator = MapAnnotationCreator()
    private let realm: Realm

    init(realm: Realm) {
        self.realm = realm
    }

    func annotations() -> [MapAnnotation] {
        let stops = realm.stops
        return mapAnnotationCreator.annotations(stops: stops)
    }
    
}
