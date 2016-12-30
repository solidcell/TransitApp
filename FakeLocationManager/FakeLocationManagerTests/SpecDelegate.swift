import CoreLocation

class SpecDelegate: NSObject, CLLocationManagerDelegate {

    var receivedAuthorizationChange: CLAuthorizationStatus?
    var receivedUpdatedLocations = [CLLocation]()
    
    func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        receivedAuthorizationChange = status
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        receivedUpdatedLocations.append(contentsOf: locations)
    }

}
