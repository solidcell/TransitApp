import CoreLocation

public class SpecUserLocation {

    public init() { }

    var location: CLLocation? {
        didSet { notifier.post() }
    }
    private let notifier = SpecMulticaster()
    
    func observe(on observer: Any, selector: Selector) {
        notifier.observe(on: observer, selector: selector)
    }

    func userIsInBerlin() {
        location = CLLocation(latitude: 52.52, longitude: 13.40)
    }
}
