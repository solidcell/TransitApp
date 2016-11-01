import RealmSwift
import MapKit

class MapAnnotationCreator {
    
    func annotations(scooters: Results<Scooter>) -> [CoupMapAnnotation] {
        return scooters.map(scooterToAnnotation)
    }

    private func scooterToAnnotation(scooter: Scooter) -> CoupMapAnnotation {
        return CoupMapAnnotation(title: scooter.licensePlate,
                                 coordinate: CLLocationCoordinate2D(latitude: scooter.latitude,
                                                                    longitude: scooter.longitude),
                                 energyLevel: scooter.energyLevel)
    }

}
