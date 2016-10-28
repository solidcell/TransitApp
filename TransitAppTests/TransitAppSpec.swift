import Quick
import RealmSwift
@testable import TransitApp

class TransitAppSpec: QuickSpec {
    
    var realm: Realm!
    
    override func spec() {
        beforeEach {
            Realm.Configuration.defaultConfiguration.inMemoryIdentifier = NSUUID().uuidString
            self.realm = try! Realm()
        }
    }
}
