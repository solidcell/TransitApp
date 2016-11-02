import RealmSwift
import MapKit

class Scooter: Object {
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var energyLevel: Int = 0
    dynamic var licensePlate: String = ""

    override class func primaryKey() -> String? {
        return "licensePlate"
    }
}

extension Scooter {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

// MARK: Creation
extension Scooter {

    convenience init(latitude: Double,
                     longitude: Double,
                     energyLevel: Int,
                     licensePlate: String) {
        self.init()
        self.latitude = latitude
        self.longitude = longitude
        self.energyLevel = energyLevel
        self.licensePlate = licensePlate
    }
    
}

// MARK: Queries
extension Realm {
    
    var scooters: Results<Scooter> {
        return objects(Scooter.self)
    }

}
