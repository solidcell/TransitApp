import RealmSwift
import MapKit

class MapOverlayProvider {
    
    private let realm: Realm
    private let mapSourceManager: MapSourceManager
    private let mapOverlayCreator = MapOverlayCreator()
    
    init(realm: Realm, mapSourceManager: MapSourceManager) {
        self.realm = realm
        self.mapSourceManager = mapSourceManager
    }

    var overlays: [MKOverlay] {
        switch mapSourceManager.source {
        case .coup:
            let businessAreas = realm.businessAreas
            return mapOverlayCreator.overlays(businessAreas: businessAreas)
        case .door2door:
            return []
        }
    }
    
}
