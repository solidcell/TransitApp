import RealmSwift

class Scooter: Object {
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var energyLevel: Int = 0
    dynamic var licensePlate: String = ""
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
