import Foundation

class NetworkResponseCreator {

    class func data(from html: String) -> Data {
        if let data = html.data(using: .utf8) {
            return data
        }
        fatalError("Couldn't create HTML Data.")
    }

    class func data(from json: [String:Any]) -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        } catch {
            fatalError("Couldn't create JSON Data.")
        }
    }
}
