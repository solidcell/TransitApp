import CoreLocation
import UIKitFringes

class CurrentLocationProvider: NSObject, CLLocationManagerDelegate {

    weak var delegate: CurrentLocationProviderDelegate!
    private let locationManager: LocationManaging
    private var wantingToStartUpdatingLocation = false
    
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

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // This can happen when location was requested, but could not be determined, for instance.
        // We should probably implement some kind of notification for the user, like a banner notice.
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if authorized { delegate?.authorizationTurnedOn() }
        else { delegate?.authorizationTurnedOff() }
    }
}
