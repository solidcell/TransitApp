import SwiftyJSON

class TransitProviderParser {
    
    func parse(json: JSON) -> [TransitProvider] {
        let providers = json["provider_attributes"].dictionary!
        return providers.map(providerDictionaryToTransitProvider)
    }
}

fileprivate extension TransitProviderParser {

    func providerDictionaryToTransitProvider(name: String, detailsJSON: JSON) -> TransitProvider {
        let details = detailsJSON.dictionary!
        return TransitProvider(name: name,
                               iconURL: details["provider_icon_url"]!.string!,
                               disclaimer: details["disclaimer"]!.string!,
                               iOSiTunesURL: details["ios_itunes_url"]?.string,
                               iOSappURL: details["ios_app_url"]?.string,
                               androidPackageName: details["android_package_name"]?.string,
                               displayName: details["display_name"]?.string)
    }

}
