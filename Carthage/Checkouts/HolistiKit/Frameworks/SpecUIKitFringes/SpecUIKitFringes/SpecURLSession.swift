import Foundation
import UIKitFringes

public class SpecURLSession: URLSessionProtocol {

    public convenience init() {
        let errorHandler = SpecErrorHandler()
        self.init(errorHandler: errorHandler)
    }

    private let errorHandler: SpecErrorHandler

    init(errorHandler: SpecErrorHandler) {
        self.errorHandler = errorHandler
    }
    
    private var requests = [SpecURLSessionDataTask]()

    public func urlDataTask(with url: URL, completionHandler: @escaping SpecURLSessionDataTask.Handler) -> URLSessionDataTaskProtocol {
        let request = SpecURLSessionDataTask(url: url.absoluteString, handler: completionHandler)
        requests.append(request)
        return request
    }

    public func respond(to url: String, with response: Response) {
        guard let request = firstRunningRequest(forURL: url) else {
            errorHandler.error(.noSuchURLRequestInProgress)
            return
        }
        request.finish(withResponse: response)
    }
    
    private func firstRunningRequest(forURL url: String) -> SpecURLSessionDataTask? {
        return requests.running.with(url: url).first
    }
}

extension SpecURLSession {

    public enum Response {
        case success(Data, URLResponse)
    }
}
