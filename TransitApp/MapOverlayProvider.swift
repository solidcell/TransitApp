import RealmSwift
import MapKit

class MapOverlayProvider {
    
    private let realm: Realm
    private let mapOverlayCreator = MapOverlayCreator()

    init(realm: Realm) {
        self.realm = realm
    }

    lazy var overlays: [MKOverlay] = {
        let businessAreas = self.realm.businessAreas
        return self.mapOverlayCreator.overlays(businessAreas: businessAreas)
    }()
    
}
