import Foundation
import SwiftyJSON
import RealmSwift

class SeedDataParser {

    private static let seedJSONfilename = "Door2DoorData"
    private let jsonParser = JSONParser()
    private let transitProviderParser = TransitProviderParser()
    private let realm: Realm
    private let routeParser: RouteParser

    init(realm: Realm) {
        self.realm = realm
        self.routeParser = RouteParser(realm: realm)
    }
    
    func seedIfNeeded() {
        let seedJSON = jsonParser.parse(filename: SeedDataParser.seedJSONfilename)
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
