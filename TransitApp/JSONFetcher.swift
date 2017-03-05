import Foundation
import UIKitFringes

class JSONFetcher: JSONFetching {

    let urlSession: URLSessionProtocol

    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }

    func fetch(url urlString: String, completion: @escaping (Any) -> Void) {
        let url = URL(string: urlString)!
        let task = urlSession.urlDataTask(with: url) { (data, urlResponse, error) in
            let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : Any]
            completion(json)
        }
        task.resume()
    }
}

protocol JSONFetching {

    func fetch(url: String, completion: @escaping (Any) -> Void)
    
}
