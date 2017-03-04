public protocol SpecDialog {

    var identifier: SpecDialogManager.DialogIdentifier { get }
    func responded(with: SpecDialogManager.Response) -> Bool
}

public struct LocationManagerDialog: SpecDialog {

    public let identifier: SpecDialogManager.DialogIdentifier
    weak var locationManager: SpecLocationManager?

    init(identifier locationManagerIdentifier: SpecDialogManager.LocationManagerIdentifier,
         locationManager: SpecLocationManager) {
        self.identifier = .locationManager(locationManagerIdentifier)
        self.locationManager = locationManager
    }
    
    public func responded(with response: SpecDialogManager.Response) -> Bool {
        guard case .locationManager(let locationManagerDialog) = identifier else { return false }
        return locationManager!.respondedTo(dialog: locationManagerDialog, with: response)
    }
}
