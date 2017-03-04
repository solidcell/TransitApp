import UIKitFringes

class URLSessionPresenter {

    fileprivate weak var viewController: URLSessionViewControlling!
    fileprivate let errorLogger: ErrorLogging

    func set(viewController: URLSessionViewControlling) {
        self.viewController = viewController
    }

    init(errorLogger: ErrorLogging) {
        self.errorLogger = errorLogger
    }

    func received(json: [String : Any]) {
        let text = String(describing: json)
        viewController.set(data: text, animated: true)
    }

    func received(html: String) {
        viewController.set(data: html, animated: true)
    }

    func receivedNothingYet() {
        viewController.set(data: "", animated: false)
    }

    func set(title text: String) {
        viewController.set(title: text)
    }
}
