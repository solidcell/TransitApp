import CoreLocation

class CurrentLocationViewModel {

    weak var delegate: CurrentLocationViewModelDelegate! {
        didSet { notifyDelegateOfCurrentLocationButtonState() }
    }
    fileprivate var currentLocationButtonState = ButtonState.nonHighlighted {
        didSet { notifyDelegateOfCurrentLocationButtonState() }
    }
    private let provider: CurrentLocationProvider

    init(provider: CurrentLocationProvider) {
        self.provider = provider
        self.provider.delegate = self
    }

    func tapCurrentLocationButton() {
        toggleCurrentLocationButtonStates()
        provider.startUpdatingLocation()
    }

    private func notifyDelegateOfCurrentLocationButtonState() {
        delegate.setCurrentLocationButtonState(currentLocationButtonState)
    }

    private func toggleCurrentLocationButtonStates() {
        switch currentLocationButtonState {
        case .nonHighlighted:
            currentLocationButtonState = .highlighted
        case .highlighted:
            currentLocationButtonState = .nonHighlighted
        }
    }
    
}

extension CurrentLocationViewModel {

    enum ButtonState {
        case nonHighlighted
        case highlighted
    }
    
}

extension CurrentLocationViewModel : CurrentLocationProviderDelegate {

    func currentLocation(_ location: CLLocation) {
        if currentLocationButtonState == .highlighted {
            delegate.centerMap(on: location.coordinate)
        }
    }

    func authorizationTurnedOff() {
        currentLocationButtonState = .nonHighlighted
    }
    
}

protocol CurrentLocationViewModelDelegate : class {
    
    func centerMap(on: CLLocationCoordinate2D)
    func setCurrentLocationButtonState(_ state: CurrentLocationViewModel.ButtonState)
    
}
