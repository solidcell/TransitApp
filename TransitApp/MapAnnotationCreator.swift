import RealmSwift
import MapKit

class MapAnnotationCreator {

    func annotations(scooters: [Scooter]) -> [CoupMapAnnotation] {
        return scooters.map(scooterToAnnotation)
    }

    func scooterToAnnotation(scooter: Scooter) -> CoupMapAnnotation {
        let annotation = CoupMapAnnotation(title: scooter.licensePlate)
        configureAnnotation(annotation: annotation, for: scooter)
        return annotation
    }

    func configureAnnotation(annotation: CoupMapAnnotation, for scooter: Scooter) {
        annotation.configure(for: scooter)
    }

}
