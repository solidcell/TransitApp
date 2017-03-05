
import MapKit

class MapOverlayProvider {
    
    private let businessAreas: [BusinessArea]
    private let mapOverlayCreator = MapOverlayCreator()

    init(businessAreas: [BusinessArea]) {
        self.businessAreas = businessAreas
    }

    lazy var overlays: [MKOverlay] = {
        return self.mapOverlayCreator.overlays(businessAreas: self.businessAreas)
    }()
    
}
