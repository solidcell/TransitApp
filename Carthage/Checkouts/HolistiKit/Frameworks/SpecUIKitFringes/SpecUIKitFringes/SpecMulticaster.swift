import Foundation

struct SpecMulticaster {

    private let notificationCenter = NotificationCenter.default
    private let notificationName = Notification.Name(String(describing: UUID()))

    func post() {
        notificationCenter.post(name: notificationName, object: nil, userInfo: nil)
    }

    func observe(on observer: Any, selector: Selector) {
        notificationCenter.addObserver(observer, selector: selector, name: notificationName, object: nil)
    }
}
