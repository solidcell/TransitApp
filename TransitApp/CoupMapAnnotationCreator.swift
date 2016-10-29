import RealmSwift
import MapKit

class CoupMapAnnotationCreator {
    
    func annotations(scooters: Results<Scooter>) -> [MapAnnotation] {
        return scooters.map(scooterToAnnotation)
    }

    private func scooterToAnnotation(scooter: Scooter) -> MapAnnotation {
        return MapAnnotation(title: "title",
                             locationName: "locationName",
                             discipline: "discipline",
                             coordinate: CLLocationCoordinate2D(latitude: scooter.latitude,
                                                                longitude: scooter.longitude))
    }
    
}
