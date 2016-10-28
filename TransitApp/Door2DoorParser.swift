import SwiftyJSON
import RealmSwift

class Door2DoorParser {
    
    private static let seedJSONfilename = "Door2DoorData"
    private let realm: Realm
    private let jsonParser = JSONParser()
    private let transitProviderParser = TransitProviderParser()
    private let routeParser: RouteParser

    init(realm: Realm) {
        self.realm = realm
        self.routeParser = RouteParser(realm: realm)
    }
    
    func seedIfNeeded() {
        if realm.transitProviders.count > 0 { return }
        
        let seedJSON = jsonParser.parse(filename: Door2DoorParser.seedJSONfilename)
        seedTransitProviders(json: seedJSON)
        seedRoutes(json: seedJSON)
    }

    private func seedTransitProviders(json: JSON) {
        let transitProviders = transitProviderParser.parse(json: json)
        try! realm.write {
            realm.add(transitProviders)
        }
    }

    private func seedRoutes(json: JSON) {
        let routes = routeParser.parse(json: json)
        try! realm.write {
            realm.add(routes)
        }
    }
    
}
