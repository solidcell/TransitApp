import RealmSwift

class MapAnnotationProvider {

    private let mapAnnotationCreator = MapAnnotationCreator()
    private let realm: Realm
    private let mapSourceManager: MapSourceManager
    
    weak var delegate: MapAnnotationProviderDelegate? {
        didSet {
            delegate?.didUpdate(annotations: annotations)
        }
    }

    init(realm: Realm, mapSourceManager: MapSourceManager) {
        self.realm = realm
        self.mapSourceManager = mapSourceManager
        mapSourceManager.delegate = self
    }

    private(set) var annotations = [MapAnnotation]() {
        didSet {
            delegate?.didUpdate(annotations: annotations)
        }
    }

    fileprivate func updateAnnotations(source: MapSourceManager.Source) {
        switch source {
        case .coup:
            let scooters = realm.scooters
            annotations = mapAnnotationCreator.annotations(scooters: scooters)
        case .door2door:
            let stops = realm.stops
            annotations = mapAnnotationCreator.annotations(stops: stops)
        }
    }

}

extension MapAnnotationProvider: MapSourceManagerDelegate {

    func didUpdate(source: MapSourceManager.Source) {
        updateAnnotations(source: source)
    }

}

protocol MapAnnotationProviderDelegate: class {
    func didUpdate(annotations: [MapAnnotation])
}
