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
        case requestAccessAlways
    }

    weak var delegate: CLLocationManagerDelegate? {
        didSet {
            delegate?.locationManager?(bsFirstArg, didChangeAuthorization: authorizationStatus())
        }
    }
    fileprivate(set) var dialog: Dialog?
    fileprivate var _authorizationStatus = CLAuthorizationStatus.notDetermined
    fileprivate let bsFirstArg = CLLocationManager()

    func setAuthorizationStatus(_ status: CLAuthorizationStatus) {
        _authorizationStatus = status
    }

    func allowAccess() {
        let accessLevel: CLAuthorizationStatus
        switch dialog! {
        case .requestAccessWhileInUse: accessLevel = .authorizedWhenInUse
        case .requestAccessAlways: accessLevel = .authorizedAlways
        }
        respondToAccessDialog(accessLevel)
    }
    
    func doNotAllowAccess() {
        respondToAccessDialog(.denied)
    }

    private func respondToAccessDialog(_ level: CLAuthorizationStatus) {
        // the dialog must currently be one asking for authorization
        if !dialog!.isOneOf(.requestAccessWhileInUse, .requestAccessAlways) {
            fatalError("The requestPermission dialog was not prompted.")
        }
        // the authorization must be one that can come from a user tap on the dialog
        if !level.isOneOf(.denied, .authorizedWhenInUse, .authorizedAlways) {
            fatalError("This is not a valid user response from the dialog.")
        }
        _authorizationStatus = level
        dialog = nil
        delegate!.locationManager?(bsFirstArg, didChangeAuthorization: authorizationStatus())
    }

    fileprivate func sendCurrentLocation() {
        if !authorizationStatus().isOneOf(.authorizedWhenInUse, .authorizedAlways) {
            fatalError("CLLocationManager would not be sending the location, since user has not authorized access.")
        }
        let fakeCurrentLocation = CLLocation(latitude: 1.0, longitude: 2.0)
        delegate!.locationManager?(bsFirstArg, didUpdateLocations: [fakeCurrentLocation])
    }

    fileprivate func locationRequestedWhenNotDetermined() {
        let error = NSError(domain: kCLErrorDomain, code: 0, userInfo: nil)
        delegate!.locationManager!(bsFirstArg, didFailWithError: error)
    }

    fileprivate func authorizationRequestForWhenInUse() {
        if dialog != nil {
            fatalError("There is already a dialog displayed. If showing another one would create a stack of dialogs, then update `dialog` to handle a stack.")
        }
        dialog = .requestAccessWhileInUse
    }

}

extension SpecLocationManager: LocationManaging {
    
    func requestWhenInUseAuthorization() {
        switch authorizationStatus() {
        case .notDetermined: authorizationRequestForWhenInUse()
        case .denied: break;
        default: fatalError("Other authorization statuses are not supported yet.")
        }
    }

    func requestLocation() {
        switch authorizationStatus() {
        case .notDetermined: locationRequestedWhenNotDetermined()
        case .authorizedWhenInUse: sendCurrentLocation()
        default: fatalError("Other authorization statuses are not supported yet.")
        }
    }
    
    func authorizationStatus() -> CLAuthorizationStatus {
        return _authorizationStatus
    }

}
