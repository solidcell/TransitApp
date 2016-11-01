import Alamofire

// NOTE: This class is not tested.
//
// It's a simple wrapper around asynchronous network code.
// If you change something here, be sure to test it manually.

class JSONFetcher: JSONFetching {

    static let scooterURL = "https://app.joincoup.com/api/v1/scooters.json"

    func fetch(url: String, completion: @escaping (Any) -> Void) {
        Alamofire.request(JSONFetcher.scooterURL).responseJSON { response in
            guard let json = response.result.value else { return }
            completion(json)
        }
    }
}

protocol JSONFetching {

    func fetch(url: String, completion: @escaping (Any) -> Void)
    
}
