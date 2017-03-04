import RealmSwift
import Foundation

class BusinessAreaCoordinate: Object {
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
}

// MARK: Creation
extension BusinessAreaCoordinate {

    convenience init(latitude: Double,
                     longitude: Double) {
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }
}
