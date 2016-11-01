import Alamofire

// NOTE: This class is not tested.
//
// It's a simple wrapper around asynchronous network code.
// If you change something here, be sure to test it manually.

class JSONFetcher: JSONFetching {

    func fetch(url: String, completion: @escaping (Any) -> Void) {
        Alamofire.request(url).responseJSON { response in
            guard let json = response.result.value else { return }
            completion(json)
        }
    }
}

protocol JSONFetching {

    func fetch(url: String, completion: @escaping (Any) -> Void)
    
}
