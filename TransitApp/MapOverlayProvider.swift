import RealmSwift
import MapKit

class MapOverlayProvider {
    
    private let realm: Realm
    private let mapSourceManager: MapSourceManager
    private let mapOverlayCreator = MapOverlayCreator()
    weak var delegate: MapOverlayProviderDelegate? {
        didSet {
            notifyDelegate()
        }
    }

    init(realm: Realm, mapSourceManager: MapSourceManager) {
        self.realm = realm
        self.mapSourceManager = mapSourceManager
        mapSourceManager.delegate = self
    }

    private(set) var overlays = [MKOverlay]() {
        didSet { notifyDelegate() }
    }

    private func notifyDelegate() {
        delegate?.didUpdate(overlays: overlays)
    }

    fileprivate func updateOverlays(source: MapSourceManager.Source) {
        switch source {
        case .coup:
            let businessAreas = realm.businessAreas
            overlays = mapOverlayCreator.overlays(businessAreas: businessAreas)
        case .door2door:
            overlays = []
        }
    }
    
}

extension MapOverlayProvider: MapSourceManagerDelegate {

    func didUpdate(source: MapSourceManager.Source) {
        updateOverlays(source: source)
    }

}

protocol MapOverlayProviderDelegate: class {
    func didUpdate(overlays: [MKOverlay])
}
