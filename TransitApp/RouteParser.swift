import SwiftyJSON
import RealmSwift

class RouteParser {

    let realm: Realm

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
    }

    func routeStructs(json: JSON) -> [RouteStruct] {
        guard let routeArray = json["routes"].array else { return [] }
        return routeArray
            .map(structForJSON)
    }

    func structForJSON(json: JSON) -> RouteStruct {
        let type = json["type"].string!
        let providerName = json["provider"].string!
        let provider = realm.objects(TransitProvider.self).filter("name = %@", providerName).first!
        return RouteStruct(provider: provider,
                           type: type)
    }

    func structToRoute(route: RouteStruct) -> Route {
        return Route(provider: route.provider,
                     type: route.type)
    }
    
}
