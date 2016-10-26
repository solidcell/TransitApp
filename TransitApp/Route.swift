import RealmSwift

class Route: Object {
    dynamic var type = ""
}

// creation
extension Route {
    convenience init(type: String) {
        self.init()
        self.type = type
    }
}
