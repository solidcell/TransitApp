import CoreLocation

extension CLLocationManager: LocationManaging {}

protocol LocationManaging: class {
    
    weak var delegate: CLLocationManagerDelegate? { get set }
    func requestLocation()
    
}
