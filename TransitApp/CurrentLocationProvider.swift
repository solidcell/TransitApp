import CoreLocation
import UIKitFringes

// This class wraps CLLocationManager(LocationManaging) interaction

class CurrentLocationProvider: NSObject {

    weak var delegate: CurrentLocationProviderDelegate!
    fileprivate let locationManager: LocationManaging
    fileprivate var wantingToStartUpdatingLocation = false
    
    init(locationManager: LocationManaging) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
    }

    var authorizationDenied: Bool {
        return locationManager.authorizationStatus() == .denied
    }
    
    var locationServicesEnabled: Bool {
        return locationManager.isLocationServicesEnabled()
    }

    func authorize() {
        locationManager.requestWhenInUseAuthorization()
    }

    var authorized: Bool {
        return locationManager.authorizationStatus().isOneOf(.authorizedWhenInUse, .authorizedAlways)
    }
    
}

extension CurrentLocationProvider: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // This can happen when location was requested, but could not be determined, for instance.
        // We should probably implement some kind of notification for the user, like a banner notice.
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if authorized { delegate?.authorizationTurnedOn() }
        else { delegate?.authorizationTurnedOff() }
    }

}

protocol CurrentLocationProviderDelegate: class {

    func authorizationTurnedOn()
    func authorizationTurnedOff()
    
}
