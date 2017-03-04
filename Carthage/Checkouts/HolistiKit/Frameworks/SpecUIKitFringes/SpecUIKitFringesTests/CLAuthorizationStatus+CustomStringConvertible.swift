import CoreLocation

extension CLAuthorizationStatus: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .notDetermined: return "notDetermined"
        case .restricted: return "restricted"
        case .authorizedAlways: return "authorizedAlways"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .denied: return "denied"
        }
    }
}
