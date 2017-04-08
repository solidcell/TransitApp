import Foundation
import UIKitFringes

class JSONFetcherFactory {

    private let urlSession: URLSessionProtocol

    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }

    func create() -> JSONFetcher {
        return JSONFetcher(urlSession: urlSession)
    }
}

class JSONFetcher {

    private let urlSession: URLSessionProtocol

    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }

    func fetch(url urlString: String, completion: @escaping (Any) -> Void) {
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        let task = urlSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
            let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : Any]
            completion(json)
        }
        task.resume()
    }
}
