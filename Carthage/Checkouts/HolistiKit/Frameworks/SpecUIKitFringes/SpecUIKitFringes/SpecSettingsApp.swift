import CoreLocation

public class SpecSettingsApp {

    private let locationAuthorizationStatus: SpecLocationAuthorizationStatus
    private let locationServices: SpecLocationServices
    
    public init(locationAuthorizationStatus: SpecLocationAuthorizationStatus,
                locationServices: SpecLocationServices) {
        self.locationAuthorizationStatus = locationAuthorizationStatus
        self.locationServices = locationServices
    }

    public func set(authorizationStatus: CLAuthorizationStatus) {
        // should there be some check here to make sure that the user would even
        // have the option to be setting a (certain) status in the Settings app?
        locationAuthorizationStatus.authorizationStatus = authorizationStatus
    }
    
    public func set(locationServicesEnabled enabled: Bool) {
        locationServices.locationServices(enabled: enabled)
    }
}
