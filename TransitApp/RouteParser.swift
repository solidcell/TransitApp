import SwiftyJSON
import RealmSwift

class RouteParser {

    fileprivate let realm: Realm
    fileprivate let segmentParser = SegmentParser()

    init(realm: Realm) {
        self.realm = realm
    }
    
    func parse(json: JSON) -> [Route] {
        return routeStructs(json: json)
            .map(structToRoute)
    }

}

fileprivate extension RouteParser {

    struct RouteStruct {
        let provider: TransitProvider
        let type: String
        let segments: [Segment]
    }

    func routeStructs(json: JSON) -> [RouteStruct] {
        guard let routeArray = json["routes"].array else { return [] }
        return routeArray
            .map(structForJSON)
    }

    func structForJSON(json: JSON) -> RouteStruct {
        let type = json["type"].string!
        let providerName = json["provider"].string!
        let provider = realm.transitProviders.with(name: providerName)!
        let segments = parseSegments(json: json)
        return RouteStruct(provider: provider,
                           type: type,
                           segments: segments)
    }

    func parseSegments(json: JSON) -> [Segment] {
        guard let segmentDictonaries = json["segments"].array else { return [] }
        return segmentDictonaries
            .map(segmentParser.parse)
    }

    func structToRoute(route: RouteStruct) -> Route {
        return Route(provider: route.provider,
                     type: route.type,
                     segments: route.segments)
    }
    
}
