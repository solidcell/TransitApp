import RealmSwift

class Stop: Object {
    dynamic var name: String?
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
}

// MARK: Creation
extension Stop {

    convenience init(name: String?,
                     latitude: Double,
                     longitude: Double) {
        self.init()
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
}

// MARK: Queries
extension Realm {
    
    var stops: Results<Stop> {
        return objects(Stop.self)
    }
    
}
