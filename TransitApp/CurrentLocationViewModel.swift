import MapKit
import UIKit

class CurrentLocationViewModel {

    weak var delegate: CurrentLocationViewModelDelegate! {
        didSet {
            notifyDelegateOfUserTrackingMode()
            notifyDelegateOfButtonState()
        }
    }
    private let provider: CurrentLocationProvider

    init(provider: CurrentLocationProvider) {
        self.provider = provider
        self.provider.delegate = self
    }

    private func notifyDelegateOfUserTrackingMode() {
        delegate.setUserTracking(mode: userTrackingMode)
    }

    private func notifyDelegateOfButtonState() {
        delegate.setCurrentLocationButtonState(buttonState)
    }

    fileprivate enum TrackingState {
        case off
        case wantingOn
        case on
    }
    
    fileprivate var userTrackingMode: MKUserTrackingMode = .none {
        didSet { notifyDelegateOfUserTrackingMode() }
    }
    
    fileprivate var buttonState: ButtonState = .nonHighlighted {
        didSet { notifyDelegateOfButtonState() }
    }

    fileprivate var trackingState = TrackingState.off {
        didSet {
            userTrackingMode = trackingState == .on ? .follow : .none
            buttonState = [.wantingOn, .on].contains(trackingState) ? .highlighted : .nonHighlighted
        }
    }

    func tapCurrentLocationButton() {
        switch userTrackingMode {
        case .none:
            if !provider.locationServicesEnabled {
                trackingState = .wantingOn
                provider.authorize()
            } else if provider.authorizationDenied {
                trackingState = .wantingOn
                showPreviouslyDeniedAlert()
            } else if provider.authorized {
                trackingState = .on
            } else {
                trackingState = .wantingOn
                provider.authorize()
            }
        default:
            trackingState = .off
        }
    }

    private func showPreviouslyDeniedAlert() {
        let url = URL(string: UIApplicationOpenSettingsURLString)!
        let alert = MapPresenter.Alert(
            title: "Please give permission",
            message: "You have previously declined permission to use your location.",
            actions: [
                MapPresenter.Alert.Action(title: "OK",
                                          style: .default,
                                          handler: .url(url)),
                MapPresenter.Alert.Action(title: "Cancel",
                                          style: .cancel,
                                          handler: .custom({ [weak self] in
                                            self?.buttonState = .nonHighlighted
                                          }))
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

protocol CurrentLocationProviderDelegate: class {

    func authorizationTurnedOn()
    func authorizationTurnedOff()
}

extension CurrentLocationViewModel: CurrentLocationProviderDelegate {

    func authorizationTurnedOn() {
        if trackingState == .wantingOn {
            trackingState = .on
        }
        delegate?.setShowCurrentLocation(true)
    }

    func authorizationTurnedOff() {
        userTrackingMode = .none
        buttonState = .nonHighlighted
        delegate?.setShowCurrentLocation(false)
    }
}

extension CurrentLocationViewModel: UserTrackingModeDelegate {

    func didChangeMode(_ mode: MKUserTrackingMode) {
        userTrackingMode = mode
        buttonState = mode == .none ? .nonHighlighted : .highlighted
    }
}
