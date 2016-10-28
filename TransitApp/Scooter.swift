import RealmSwift

class Scooter: Object {
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
}

// MARK: Creation
extension Scooter {

    convenience init(latitude: Double,
                     longitude: Double) {
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }
    
}

// MARK: Queries
extension Realm {
    
    var scooters: Results<Scooter> {
        return objects(Scooter.self)
    }

}
