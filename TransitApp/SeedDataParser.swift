import Foundation
import SwiftyJSON
import RealmSwift

class SeedDataParser {

    private static let seedJSONfilename = "Door2DoorData"
    private let jsonParser = JSONParser()
    private let transitProviderParser = TransitProviderParser()
    private let realm: Realm

    init(realm: Realm) {
        self.realm = realm
    }
    
    func seedIfNeeded() {
        let seedJSON = jsonParser.parse(filename: SeedDataParser.seedJSONfilename)
        seedTransitProviders(json: seedJSON)
    }

    private func seedTransitProviders(json: JSON) {
        let transitProviders = transitProviderParser.parse(json: json)
        try! realm.write {
            realm.add(transitProviders)
        }
    }
    
}
