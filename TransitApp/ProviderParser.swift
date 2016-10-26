import SwiftyJSON

class ProviderParser {
    
    func parse(json: JSON) -> [Provider] {
        return providerStructs(json: json)
            .map(structToProvider)
    }
}

fileprivate extension ProviderParser {

   struct ProviderStruct {
        let name: String
        let details: Details
    }

    struct Details {
        let iconURL: String
        let disclaimer: String
        let iOSiTunesURL: String?
        let iOSappURL: String?
        let androidPackageName: String?
        let displayName: String?
    }

    func structToProvider(_ provider: ProviderStruct) -> Provider {
        let details = provider.details
        return Provider(name: provider.name,
                        iconURL: details.iconURL,
                        disclaimer: details.disclaimer,
                        iOSiTunesURL: details.iOSiTunesURL,
                        iOSappURL: details.iOSappURL,
                        androidPackageName: details.androidPackageName,
                        displayName: details.displayName)
    }

    func providerStructs(json: JSON) -> [ProviderStruct] {
        guard let providers = json["provider_attributes"].dictionary else { return [] }
        return providers.map(providerDictionarytoStruct)
            .filterNil()
    }

    func providerDictionarytoStruct(name: String, attributes: JSON) -> ProviderStruct? {
        guard let details = details(json: attributes) else { return nil }
        return ProviderStruct(name: name, details: details)
    }
    
    func details(json: JSON) -> Details? {
        guard let details = json.dictionary else { return nil }
        return Details(iconURL: details["provider_icon_url"]!.string!,
                       disclaimer: details["disclaimer"]!.string!,
                       iOSiTunesURL: details["ios_itunes_url"]?.string,
                       iOSappURL: details["ios_app_url"]?.string,
                       androidPackageName: details["android_package_name"]?.string,
                       displayName: details["display_name"]?.string)
    }

}
