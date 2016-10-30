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

// MARK: Queries
extension Realm {

    var businessAreas: Results<BusinessArea> {
        return objects(BusinessArea.self)
    }
    
}
