import RealmSwift

class Segment: Object {
    dynamic var name: String?
}

// MARK: Creation
extension Segment {
    convenience init(name: String?) {
        self.init()
        self.name = name
    }
}
