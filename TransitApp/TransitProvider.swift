import RealmSwift

class TransitProvider: Object {
    dynamic var name = ""
    dynamic var iconURL = ""
    dynamic var disclaimer = ""
    dynamic var iOSiTunesURL: String?
    dynamic var iOSappURL: String?
    dynamic var androidPackageName: String?
    dynamic var displayName: String?

    override class func primaryKey() -> String? { return "name" }
}

// MARK: Creation
extension TransitProvider {
    convenience init(name: String,
                     iconURL: String,
                  disclaimer: String,
                  iOSiTunesURL: String? = nil,
                  iOSappURL: String? = nil,
                  androidPackageName: String? = nil,
                  displayName: String? = nil) {
        self.init()
        self.name = name
        self.iconURL = iconURL
        self.disclaimer = disclaimer
        self.iOSiTunesURL = iOSiTunesURL
        self.iOSappURL = iOSappURL
        self.androidPackageName = androidPackageName
        self.displayName = displayName
    }
}

// MARK: Queries
extension Realm {
    
    var transitProviders: Results<TransitProvider> {
        return objects(TransitProvider.self)
    }
    
}

extension Results where Element: TransitProvider {

    func with(name: String) -> Element? {
        return filter("name = %@", name).first
    }
    
}
