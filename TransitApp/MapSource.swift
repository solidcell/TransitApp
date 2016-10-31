import RealmSwift

class MapSource: Object {
    dynamic var enumValue = MapSourceManager.Source.door2door
    dynamic var createdAt = NSDate()
}

// MARK: Creation
extension MapSource {

    convenience init(source: MapSourceManager.Source) {
        self.init()
        self.enumValue = source
    }
    
}

// MARK: Queries
extension Realm {

    var mapSources: Results<MapSource> {
        return objects(MapSource.self)
    }

    var currentMapSource: MapSource? {
        return mapSources.sorted.last
    }
    
}

extension Results where Element: MapSource {

    var sorted: Results<Element> {
        return sorted(byProperty: "createdAt", ascending: true)
    }

}
