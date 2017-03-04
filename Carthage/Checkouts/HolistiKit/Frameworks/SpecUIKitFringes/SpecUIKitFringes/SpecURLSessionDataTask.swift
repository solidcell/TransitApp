import Foundation
import UIKitFringes

public class SpecURLSessionDataTask: URLSessionDataTaskProtocol {

    public typealias Handler = (Data?, URLResponse?, Error?) -> Void

    let url: String
    public var state: URLSessionTask.State = .suspended
    private let handler: Handler

    init(url: String, handler: @escaping Handler) {
        self.url = url
        self.handler = handler
    }

    public func resume() {
        state = .running
    }

    func finish(withResponse response: SpecURLSession.Response) {
        state = .completed
        switch response {
        case .success(let data, let urlResponse):
            handler(data, urlResponse, nil)
        }
    }
}

extension Array where Element: SpecURLSessionDataTask {

    var running: [Element] {
        return filter { $0.state == .running }
    }

    func with(url: String) -> [Element] {
        return filter { $0.url == url }
    }
}
