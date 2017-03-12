import Foundation
import SpecUIKitFringes

class TransitAppSpecSystem: SpecSystem {
    
    let locationServices = SpecLocationServices()
    let dateProvider = SpecDateProvider()
    let userLocation = SpecUserLocation()
    let locationAuthorizationStatus = SpecLocationAuthorizationStatus()
    
    weak var urlSession: SpecURLSession!
    weak var dialogManager: SpecDialogManager!

    var settingsApp: SpecSettingsApp {
        return SpecSettingsApp(locationAuthorizationStatus: locationAuthorizationStatus,
                               locationServices: locationServices)
    }

    override open func createAppDelegateBundle() -> AppDelegateBundle {
        let _dialogManager = SpecDialogManager()
        self.dialogManager = _dialogManager
        let _urlSession = SpecURLSession()
        self.urlSession = _urlSession
        let locationManagerFactory = SpecLocationManagerFactory(dialogManager: dialogManager,
                                                                userLocation: userLocation,
                                                                locationServices: locationServices,
                                                                locationAuthorizationStatus: locationAuthorizationStatus)
        let appDelegate = SpecAppDelegate(dialogManager: dialogManager,
                                          dateProvider: dateProvider,
                                          urlSession: urlSession,
                                          locationManagerFactory: locationManagerFactory)
        return AppDelegateBundle(appDelegate: appDelegate,
                                 temporarilyStrong: [dialogManager, urlSession, locationManagerFactory])
    }
}
