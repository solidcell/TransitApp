import CoreLocation
import FakeLocationManager

extension CLLocationManager: LocationManaging {

    /*
     Expose these methods via instances, since they need to be testable.
     If they were class functions, in FakeLocationManager their backing
     variables would need to be class variables, be Swift doesn't support
     class variables, so they would have to be static, but static won't
     reset itself between tests, so the values would pollute other tests.
     */
    
    public func authorizationStatus() -> CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    public func isLocationServicesEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }

}
