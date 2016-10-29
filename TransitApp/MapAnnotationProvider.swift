import RealmSwift

class MapAnnotationProvider {

    weak var delegate: MapAnnotationProviderDelegate?
    private let mapAnnotationCreator = MapAnnotationCreator()
    private let realm: Realm

    init(realm: Realm) {
        self.realm = realm

        defer {
            source = .door2door
        }
    }

    private(set) var annotations = [MapAnnotation]() {
        didSet {
            delegate?.didUpdate(annotations: annotations)
        }
    }

    // TODO move the Source source to a different class (and sync with segmented control source)
    var source = Source.door2door {
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

    // TODO also move this
    enum Source {
        case coup
        case door2door
    }
    
}

protocol MapAnnotationProviderDelegate: class {
    func didUpdate(annotations: [MapAnnotation])
}
