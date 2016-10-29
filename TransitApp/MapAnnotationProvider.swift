import RealmSwift

class MapAnnotationProvider {

    weak var delegate: MapAnnotationProviderDelegate?
    private let mapAnnotationCreator = MapAnnotationCreator()
    private let realm: Realm
    private let mapSourceManager: MapSourceManager

    init(realm: Realm, mapSourceManager: MapSourceManager) {
        self.realm = realm
        self.mapSourceManager = mapSourceManager

        defer {
            source = mapSourceManager.source
        }
    }

    private(set) var annotations = [MapAnnotation]() {
        didSet {
            delegate?.didUpdate(annotations: annotations)
        }
    }

    // TODO move the Source source to a different class (and sync with segmented control source)
    var source = MapSourceManager.Source.door2door {
        didSet {
            switch source {
            case .coup:
                annotations = []
            case .door2door:
                let stops = realm.stops
                annotations = mapAnnotationCreator.annotations(stops: stops)
            }
        }
    }

}

protocol MapAnnotationProviderDelegate: class {
    func didUpdate(annotations: [MapAnnotation])
}
