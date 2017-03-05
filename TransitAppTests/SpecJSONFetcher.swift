@testable import TransitApp

class SpecJSONFetcher: JSONFetching {

    var completion: ((Any) -> Void)?

    func fetch(url: String, completion: @escaping (Any) -> Void) {
        self.completion = completion
    }

    func fetchSuccess(_ responseValue: Any) {
        completion?(responseValue)
        completion = nil
    }

}
