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
    
}

protocol MapSourceManagerDelegate: class {
    func didUpdate(source: MapSourceManager.Source)
}
