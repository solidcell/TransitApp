import RealmSwift
import MapKit

class MapOverlayProvider {
    
    private let realm: Realm
    private let source: MapSourceManager.Source
    private let mapOverlayCreator = MapOverlayCreator()

    init(realm: Realm, source: MapSourceManager.Source) {
        self.realm = realm
        self.source = source
    }

    lazy var overlays: [MKOverlay] = {
        switch self.source {
        case .coup:
            let businessAreas = self.realm.businessAreas
            return self.mapOverlayCreator.overlays(businessAreas: businessAreas)
        case .door2door:
            return []
        }
    }()
    
}
