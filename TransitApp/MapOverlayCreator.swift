import MapKit
import RealmSwift

class MapOverlayCreator {

    func overlays(businessAreas: Results<BusinessArea>) -> [MKOverlay] {
        return businessAreas.map(businessAreaToMapOverlay)
    }

    private func businessAreaToMapOverlay(businessArea: BusinessArea) -> MKOverlay {
        let coordinates = businessArea.coordinates.map(businessAreaCoordinateToMapCoordinate)
        let coordinatesArray = Array(coordinates)
        let overlay = MKPolygon(coordinates: coordinatesArray, count: coordinatesArray.count)
        return overlay
    }

    private func businessAreaCoordinateToMapCoordinate(businessAreaCoordinate: BusinessAreaCoordinate) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: businessAreaCoordinate.latitude,
                                      longitude: businessAreaCoordinate.longitude)
    }
    
}
