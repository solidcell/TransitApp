import RealmSwift

class Route: Object {
    dynamic var provider: TransitProvider!
    dynamic var type = ""
    let segments = List<Segment>()
}

// MARK: Creation
extension Route {
    convenience init(provider: TransitProvider,
                     type: String,
                     segments: [Segment]) {
        self.init()
        self.provider = provider
        self.type = type
        self.segments.append(objectsIn: segments)
    }
}
