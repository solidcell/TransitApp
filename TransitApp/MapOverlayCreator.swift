import MapKit
import RealmSwift

class MapOverlayCreator {

    func overlays(businessAreas: [BusinessArea]) -> [MKOverlay] {
        return businessAreas.map(businessAreaToMapOverlay)
    }

    private func businessAreaToMapOverlay(businessArea: BusinessArea) -> MKOverlay {
        let coordinates = businessArea.coordinates
        return MKPolygon(coordinates: coordinates, count: coordinates.count)
    }
}
