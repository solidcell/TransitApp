import CoreLocation

class CurrentLocationProvider {

    weak var delegate: CurrentLocationProviderDelegate?
    private let fakeCurrentLocation = CLLocation(latitude: 1.0, longitude: 2.0)

    func getCurrentLocation() {
        delegate?.currentLocation(fakeCurrentLocation)
    }
    
}

protocol CurrentLocationProviderDelegate: class {

    func currentLocation(_ location: CLLocation)
    
}
