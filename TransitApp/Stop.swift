import RealmSwift

class Stop: Object {
    dynamic var name: String?
    dynamic var longitude: Double = 0.0
    dynamic var latitude: Double = 0.0
}

// MARK: Creation
extension Stop {

    convenience init(name: String?,
                     longitude: Double,
                     latitude: Double) {
        self.init()
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
    }
    
}
