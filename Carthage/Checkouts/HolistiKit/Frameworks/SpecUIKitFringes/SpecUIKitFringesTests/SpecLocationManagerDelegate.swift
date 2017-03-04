import CoreLocation

class SpecLocationManagerDelegate: NSObject, CLLocationManagerDelegate {

    var receivedAuthorizationChange: CLAuthorizationStatus?
    var receivedUpdatedLocations = [CLLocation]()
    var receivedError: Error?
    
    func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        receivedAuthorizationChange = status
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        receivedUpdatedLocations.append(contentsOf: locations)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        receivedError = error
    }

}
