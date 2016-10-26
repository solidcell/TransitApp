import SwiftyJSON

class RouteParser {
    
    func parse(json: JSON) -> [Route] {
        return routeStructs(json: json)
            .map(structToRoute)
    }

}

fileprivate extension RouteParser {

    struct RouteStruct {
        let type: String
    }

    func routeStructs(json: JSON) -> [RouteStruct] {
        guard let routeArray = json["routes"].array else { return [] }
        return routeArray
            .map(structForJSON)
    }

    func structForJSON(json: JSON) -> RouteStruct {
        let type = json["type"].string!
        return RouteStruct(type: type)
    }

    func structToRoute(route: RouteStruct) -> Route {
        return Route(type: route.type)
    }
    
}
