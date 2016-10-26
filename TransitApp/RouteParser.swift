import SwiftyJSON
import RealmSwift

class RouteParser {

    fileprivate let realm: Realm
    fileprivate let segmentParser = SegmentParser()

    init(realm: Realm) {
        self.realm = realm
    }
    
    func parse(json: JSON) -> [Route] {
        guard let routeArray = json["routes"].array else { return [] }
        return routeArray.map(jsonToRoute)
    }

}

fileprivate extension RouteParser {

    func jsonToRoute(json: JSON) -> Route {
        let type = json["type"].string!
        let providerName = json["provider"].string!
        let provider = realm.transitProviders.with(name: providerName)!
        let segments = parseSegments(json: json)
        return Route(provider: provider,
                     type: type,
                     segments: segments)
    }

    func parseSegments(json: JSON) -> [Segment] {
        guard let segmentDictonaries = json["segments"].array else { return [] }
        return segmentDictonaries.map(segmentParser.parse)
    }
    
}
