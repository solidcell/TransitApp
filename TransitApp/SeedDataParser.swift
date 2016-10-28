import Foundation
import SwiftyJSON
import RealmSwift

class SeedDataParser {

    private let door2DoorParser: Door2DoorParser
    private let coupParser: CoupParser

    init(realm: Realm) {
        self.door2DoorParser = Door2DoorParser(realm: realm)
        self.coupParser = CoupParser(realm: realm)
    }
    
    func seedIfNeeded() {
        door2DoorParser.seedIfNeeded()
        coupParser.seedIfNeeded()
    }
    
}
