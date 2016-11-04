import CoreLocation
@testable import TransitApp

/*
 This class is used in place of CLLocationManager while in specs.
 It conforms to a subset of the same interface via LocationManaging.
 This allows us to test code which relies on behavior which is not
 normally under our control in CLLocationManager. It also allows us
 to document assumptions about how CLLocationManager works (based on 
 documentation and experimenting with it).
*/

class SpecLocationManager {

    // this probably belongs in a Spec UIApplication
    enum Dialog {
        case requestAccessWhileInUse
    }

    weak var delegate: CLLocationManagerDelegate?
    fileprivate(set) var dialog: Dialog?
    fileprivate var _authorizationStatus = CLAuthorizationStatus.notDetermined
    fileprivate let bsFirstArg = CLLocationManager()

    func allowAccess() {
        respondToAccessDialog(.authorizedWhenInUse)
        sendCurrentLocation()
    }
    
    func doNotAllowAccess() {
        respondToAccessDialog(.denied)
    }

    private func respondToAccessDialog(_ level: CLAuthorizationStatus) {
        if dialog != .requestAccessWhileInUse { fatalError("The requestPermission dialog was not prompted") }
        _authorizationStatus = level
        dialog = nil
    }

    private func sendCurrentLocation() {
        let fakeCurrentLocation = CLLocation(latitude: 1.0, longitude: 2.0)
        delegate!.locationManager?(bsFirstArg, didUpdateLocations: [fakeCurrentLocation])
    }

}

extension SpecLocationManager: LocationManaging {

    func requestLocation() {
        dialog = .requestAccessWhileInUse
    }
    
    func authorizationStatus() -> CLAuthorizationStatus {
        return _authorizationStatus
    }

}
