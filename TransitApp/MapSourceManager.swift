import RealmSwift

class MapSourceManager {

    private let realm: Realm
    private let defaultSource = Source.door2door

    init(realm: Realm) {
        self.realm = realm
    }

    weak var delegate: MapSourceManagerDelegate? {
        didSet {
            delegate?.didUpdate()
        }
    }

    @objc enum Source: Int {
        case coup
        case door2door
    }

    var source: Source {
        get {
            return realm.currentMapSource?.enumValue ?? defaultSource
        }
        set {
            let mapSource = MapSource(source: newValue)
            try! realm.write {
                realm.add(mapSource)
            }
            delegate?.didUpdate()
        }
    }

    var sources: AnyIterator<Source> {
        return iterateEnum(Source.self)
    }
    
}

extension MapSourceManager: SegmentedControlSourceDelegate {

    func didSelect(source: MapSourceManager.Source) {
        self.source = source
    }
    
}

protocol MapSourceManagerDelegate: class {
    func didUpdate()
}
