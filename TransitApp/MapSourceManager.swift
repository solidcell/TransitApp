import Foundation

class MapSourceManager {

    weak var delegate: MapSourceManagerDelegate? {
        didSet {
            delegate?.didUpdate(source: source)
        }
    }

    enum Source {
        case coup
        case door2door
    }

    var source = Source.door2door {
        didSet {
            delegate?.didUpdate(source: source)
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
    func didUpdate(source: MapSourceManager.Source)
}
