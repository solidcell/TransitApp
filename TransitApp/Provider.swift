import RealmSwift

class Provider: Object {
    dynamic var name = ""
    dynamic var iconURL = ""
    dynamic var disclaimer = ""
    dynamic var iOSiTunesURL: String?
    dynamic var iOSappURL: String?
    dynamic var androidPackageName: String?
    dynamic var displayName: String?
}

// creation
extension Provider {
    convenience init(name: String,
                     iconURL: String,
                  disclaimer: String,
                  iOSiTunesURL: String?,
                  iOSappURL: String?,
                  androidPackageName: String?,
                  displayName: String?) {
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
