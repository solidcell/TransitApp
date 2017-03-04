import CoreLocation

public class SpecLocationAuthorizationStatus {

    private let notifier = SpecMulticaster()

    public init() { }
    
    var authorizationStatus = CLAuthorizationStatus.notDetermined {
        didSet { notifier.post() }
    }
    
    func observe(on observer: Any, selector: Selector) {
        notifier.observe(on: observer, selector: selector)
    }
}
