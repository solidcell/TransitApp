import RealmSwift

class Route: Object {
    dynamic var provider: TransitProvider!
    dynamic var type = ""
}

// creation
extension Route {
    convenience init(provider: TransitProvider,
                     type: String) {
        self.init()
        self.provider = provider
        self.type = type
    }
}
