import MapKit

// For now, this class just returns a default region for the map.
// It should eventually provide a custom region based on
// annotations and/or overlays

class MapRegionProvider {

    private let distance: CLLocationDistance = 23000
    private let coordinate = CLLocationCoordinate2D(latitude: 52.52,
                                                    longitude: 13.4145)

    var region: MKCoordinateRegion {
        return MKCoordinateRegionMakeWithDistance(self.coordinate,
                                                  self.distance, self.distance)
    }

}
