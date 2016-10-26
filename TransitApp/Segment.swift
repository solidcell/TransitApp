import RealmSwift

class Segment: Object {
    dynamic var name: String?
    let stops = List<Stop>()
}

// MARK: Creation
extension Segment {
    convenience init(name: String?,
                     stops: [Stop]) {
        self.init()
        self.name = name
        self.stops.append(objectsIn: stops)
    }
}
