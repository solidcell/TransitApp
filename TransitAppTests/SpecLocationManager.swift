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
        case requestJumpToLocationServicesSettings
    }

    weak var delegate: CLLocationManagerDelegate? {
        didSet { sendCurrentStatus() }
    }
    fileprivate(set) var dialog: Dialog?
    fileprivate var _authorizationStatus = CLAuthorizationStatus.notDetermined
    fileprivate var _locationServicesEnabled = true {
        didSet { sendCurrentStatus() }
    }
    fileprivate var locationServicesDialogResponseCount = 0
    fileprivate let bsFirstArg = CLLocationManager()

    fileprivate func sendCurrentLocation() {
        if !authorizationStatus().isOneOf(.authorizedWhenInUse, .authorizedAlways) {
            fatalError("CLLocationManager would not be sending the location, since user has not authorized access.")
        }
        let fakeCurrentLocation = CLLocation(latitude: 1.0, longitude: 2.0)
        delegate!.locationManager?(bsFirstArg, didUpdateLocations: [fakeCurrentLocation])
    }

    fileprivate func sendCurrentStatus() {
        delegate?.locationManager?(bsFirstArg, didChangeAuthorization: authorizationStatus())
    }

    fileprivate func locationRequestedWhenNotDetermined() {
        let error = NSError(domain: kCLErrorDomain, code: 0, userInfo: nil)
        delegate!.locationManager!(bsFirstArg, didFailWithError: error)
    }

    fileprivate func authorizationRequestForWhenInUseWhenLocationEnabled() {
        fatalErrorIfCurrentlyADialog()
        dialog = .requestAccessWhileInUse
    }

    fileprivate func authorizationRequestForWhenInUseWhenLocationDisabled() {
        if !iOSwillPermitALocationServicesDialogToBeShown { return }
        fatalErrorIfCurrentlyADialog()
        dialog = .requestJumpToLocationServicesSettings
    }

    private var iOSwillPermitALocationServicesDialogToBeShown: Bool {
        // iOS will only ever show the user this dialog twice for this app
        return locationServicesDialogResponseCount < 2
    }

    private func fatalErrorIfCurrentlyADialog() {
        if dialog != nil {
            fatalError("There is already a dialog displayed. If showing another one would create a stack of dialogs, then update `dialog` to handle a stack.")
        }
    }

}

// MARK: User taps for Location Services
extension SpecLocationManager {

    /* Both "Settings" and "Cancel" buttons have the same
     effect on the app and state in the ways we care.
     "Settings" will additionally background the app, but
     we don't care about that, at least yet.
     */
    func tapAnyLocationServicesResponse() {
        if dialog != .requestJumpToLocationServicesSettings {
            fatalError("The dialog to jump to Location Services was not prompted.")
        }
        dialog = nil
        locationServicesDialogResponseCount += 1
    }
    
}

// MARK: User taps for authorization dialog prompts
extension SpecLocationManager {

    func allowAccess() {
        let accessLevel: CLAuthorizationStatus
        switch dialog! {
        case .requestAccessWhileInUse: accessLevel = .authorizedWhenInUse
        case .requestAccessAlways: accessLevel = .authorizedAlways
        case .requestJumpToLocationServicesSettings: fatalErrorWrongDialog(); accessLevel = .authorizedAlways
        }
        respondToAccessDialog(accessLevel)
    }
    
    func doNotAllowAccess() {
        respondToAccessDialog(.denied)
    }

    private func fatalErrorWrongDialog() {
        fatalError("The requestPermission dialog was not prompted.")
    }

    private func respondToAccessDialog(_ level: CLAuthorizationStatus) {
        // the dialog must currently be one asking for authorization
        if !dialog!.isOneOf(.requestAccessWhileInUse, .requestAccessAlways) {
            fatalErrorWrongDialog()
        }
        // the authorization must be one that can come from a user tap on the dialog
        if !level.isOneOf(.denied, .authorizedWhenInUse, .authorizedAlways) {
            fatalError("This is not a valid user response from the dialog.")
        }
        _authorizationStatus = level
        dialog = nil
        sendCurrentStatus()
    }
    
}

// MARK: User's settings in the Settings app
extension SpecLocationManager {

    func setAuthorizationStatus(_ status: CLAuthorizationStatus) {
        _authorizationStatus = status
    }

    func setLocationServicesEnabled(_ enabled: Bool) {
        _locationServicesEnabled = enabled
    }

}

// MARK: LocationManaging
extension SpecLocationManager: LocationManaging {
    
    func requestWhenInUseAuthorization() {
        switch authorizationStatus() {
        case .notDetermined: authorizationRequestForWhenInUseWhenLocationEnabled()
        case .denied:
            if !isLocationServicesEnabled() { authorizationRequestForWhenInUseWhenLocationDisabled() }
        case .authorizedWhenInUse: break;
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
        if !isLocationServicesEnabled() { return .denied }
        return _authorizationStatus
    }

    func isLocationServicesEnabled() -> Bool {
        return _locationServicesEnabled
    }

}
