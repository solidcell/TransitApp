import CoreLocation

// TODO consider making FakeLocationManager a
// subclass of CLLocationManager and getting rid
// of this protocol.  It would be easier to drop
// into a project too.  Also, probably a good idea
// to override unimplemented methods and then fatalError.

protocol LocationManaging: class {

    // Supported subset interface from CLLocationManager
    weak var delegate: CLLocationManagerDelegate? { get set }
    var location: CLLocation? { get }
    func requestLocation()
    func authorizationStatus() -> CLAuthorizationStatus
    func requestWhenInUseAuthorization()
    func isLocationServicesEnabled() -> Bool
    
}
