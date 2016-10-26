import SwiftyJSON

class TransitProviderParser {
    
    func parse(json: JSON) -> [TransitProvider] {
        return providerStructs(json: json)
            .map(structToTransitProvider)
    }
}

fileprivate extension TransitProviderParser {

   struct TransitProviderStruct {
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

    func structToTransitProvider(_ provider: TransitProviderStruct) -> TransitProvider {
        let details = provider.details
        return TransitProvider(name: provider.name,
                        iconURL: details.iconURL,
                        disclaimer: details.disclaimer,
                        iOSiTunesURL: details.iOSiTunesURL,
                        iOSappURL: details.iOSappURL,
                        androidPackageName: details.androidPackageName,
                        displayName: details.displayName)
    }

    func providerStructs(json: JSON) -> [TransitProviderStruct] {
        guard let providers = json["provider_attributes"].dictionary else { return [] }
        return providers.map(providerDictionarytoStruct)
            .filterNil()
    }

    func providerDictionarytoStruct(name: String, attributes: JSON) -> TransitProviderStruct? {
        guard let details = details(json: attributes) else { return nil }
        return TransitProviderStruct(name: name, details: details)
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
