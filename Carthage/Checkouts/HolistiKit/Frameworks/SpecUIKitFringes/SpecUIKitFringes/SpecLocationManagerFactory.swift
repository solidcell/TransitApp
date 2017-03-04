import UIKitFringes

public class SpecLocationManagerFactory: LocationManagingFactoryProtocol {
    
    private let dialogManager: SpecDialogManager
    private let errorHandler: SpecErrorHandler
    private let userLocation: SpecUserLocation
    private let locationServices: SpecLocationServices
    private let locationAuthorizationStatus: SpecLocationAuthorizationStatus

    public convenience init(dialogManager: SpecDialogManager,
                            userLocation: SpecUserLocation,
                            locationServices: SpecLocationServices,
                            locationAuthorizationStatus: SpecLocationAuthorizationStatus) {
        let errorHandler = SpecErrorHandler()
        self.init(dialogManager: dialogManager,
                  errorHandler: errorHandler,
                  userLocation: userLocation,
                  locationServices: locationServices,
                  locationAuthorizationStatus: locationAuthorizationStatus)
        }

    init(dialogManager: SpecDialogManager,
         errorHandler: SpecErrorHandler,
         userLocation: SpecUserLocation,
         locationServices: SpecLocationServices,
         locationAuthorizationStatus: SpecLocationAuthorizationStatus) {
        self.dialogManager = dialogManager
        self.errorHandler = errorHandler
        self.userLocation = userLocation
        self.locationServices = locationServices
        self.locationAuthorizationStatus = locationAuthorizationStatus
    }

    public func create() -> LocationManaging {
        return SpecLocationManager(dialogManager: dialogManager,
                                   errorHandler: errorHandler,
                                   userLocation: userLocation,
                                   locationServices: locationServices,
                                   locationAuthorizationStatus: locationAuthorizationStatus)
    }
}
