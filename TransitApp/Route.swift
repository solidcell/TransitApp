import RealmSwift

class Route: Object {
    dynamic var provider: Provider!
    dynamic var type = ""
}

// creation
extension Route {
    convenience init(provider: Provider,
                     type: String) {
        self.init()
        self.provider = provider
        self.type = type
    }
}
