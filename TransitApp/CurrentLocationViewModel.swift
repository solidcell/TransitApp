import CoreLocation
import UIKit

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
        if provider.authorizationDenied {
            showPreviouslyDeniedAlert()
            return
        }
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

    private func showPreviouslyDeniedAlert() {
        guard let url = URL(string: UIApplicationOpenSettingsURLString) else { return }
        let alert = MapViewModel.Alert(
            title: "Please give permission",
            message: "You have previously declined permission to use your location.",
            actions: [
                MapViewModel.Alert.Action(title: "OK",
                                          style: .default,
                                          handler: .url(url)),
                MapViewModel.Alert.Action(title: "Cancel",
                                          style: .cancel,
                                          handler: .noop)
            ])
        delegate.showAlert(alert)
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
    func showAlert(_ alert: MapViewModel.Alert)
    
}
