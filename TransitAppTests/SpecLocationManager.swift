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

    weak var delegate: CLLocationManagerDelegate?
    fileprivate(set) var dialog: Dialog?
    fileprivate var _authorizationStatus = CLAuthorizationStatus.notDetermined
    fileprivate let bsFirstArg = CLLocationManager()

    func allowAccess() {
        let accessLevel: CLAuthorizationStatus
        switch dialog! {
        case .requestAccessWhileInUse: accessLevel = .authorizedWhenInUse
        case .requestAccessAlways: accessLevel = .authorizedAlways
        }
        respondToAccessDialog(accessLevel)
        sendCurrentLocation()
    }
    
    func doNotAllowAccess() {
        respondToAccessDialog(.denied)
    }

    private func respondToAccessDialog(_ level: CLAuthorizationStatus) {
        if !dialog!.isOneOf(.requestAccessWhileInUse, .requestAccessAlways) {
            fatalError("The requestPermission dialog was not prompted.")
        }
        if !level.isOneOf(.denied, .authorizedWhenInUse, .authorizedAlways) {
            fatalError("This is not a valid user response from the dialog.")
        }
        _authorizationStatus = level
        dialog = nil
    }

    private func sendCurrentLocation() {
        if !authorizationStatus().isOneOf(.authorizedWhenInUse, .authorizedAlways) {
            fatalError("CLLocationManager would not be sending the location, since user has not authorized access.")
        }
        let fakeCurrentLocation = CLLocation(latitude: 1.0, longitude: 2.0)
        delegate!.locationManager?(bsFirstArg, didUpdateLocations: [fakeCurrentLocation])
    }

}

extension SpecLocationManager: LocationManaging {

    func requestLocation() {
        if dialog != nil {
            fatalError("There is already a dialog displayed. If showing another one would create a stack of dialogs, then update `dialog` to handle a stack.")
        }
        dialog = .requestAccessWhileInUse
    }
    
    func authorizationStatus() -> CLAuthorizationStatus {
        return _authorizationStatus
    }

}
