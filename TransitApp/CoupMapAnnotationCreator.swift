import RealmSwift
import MapKit

class CoupMapAnnotationCreator {
    
    func annotations(scooters: Results<Scooter>) -> [Door2DoorMapAnnotation] {
        return scooters.map(scooterToAnnotation)
    }

    private func scooterToAnnotation(scooter: Scooter) -> Door2DoorMapAnnotation {
        return Door2DoorMapAnnotation(title: "title",
                                      locationName: "locationName",
                                      discipline: "discipline",
                                      coordinate: CLLocationCoordinate2D(latitude: scooter.latitude,
                                                                         longitude: scooter.longitude))
    }
    
}
