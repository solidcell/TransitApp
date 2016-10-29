import RealmSwift
import MapKit

class CoupMapAnnotationCreator {
    
    func annotations(scooters: Results<Scooter>) -> [CoupMapAnnotation] {
        return scooters.map(scooterToAnnotation)
    }

    private func scooterToAnnotation(scooter: Scooter) -> CoupMapAnnotation {
        return CoupMapAnnotation(title: "title",
                                 locationName: "locationName",
                                 discipline: "discipline",
                                 coordinate: CLLocationCoordinate2D(latitude: scooter.latitude,
                                                                    longitude: scooter.longitude))
    }

}
