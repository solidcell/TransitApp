import Foundation

extension URLSession: URLSessionProtocol {

    public func urlDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return dataTask(with: url, completionHandler: completionHandler)
    }
}

public protocol URLSessionProtocol {

    func urlDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }

public protocol URLSessionDataTaskProtocol {
    
    var state: URLSessionTask.State { get }
    func resume()
}
