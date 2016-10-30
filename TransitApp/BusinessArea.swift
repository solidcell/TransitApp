import RealmSwift

class BusinessArea: Object {
    let coordinates = List<BusinessAreaCoordinate>()
}

// MARK: Creation
extension BusinessArea {

    convenience init(coordinates: [BusinessAreaCoordinate]) {
        self.init()
        self.coordinates.append(objectsIn: coordinates)
    }
    
}
