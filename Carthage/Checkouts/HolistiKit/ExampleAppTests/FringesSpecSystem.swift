import SpecUIKitFringes

class FringesSpecSystem: SpecSystem {

    let sharedApplication = SpecSharedApplication()
    let dateProvider = SpecDateProvider()
    let timeZoneProvider = SpecTimeZoneProvider()
    let userLocation = SpecUserLocation()
    
    weak var urlSession: SpecURLSession!
    weak var dialogManager: SpecDialogManager!

    override open func createAppDelegateBundle() -> AppDelegateBundle {
        // TODO if these were created via a factory which will aggregate their state it wouldn't be necessary to play this weak/strong game
        let _urlSession = SpecURLSession()
        self.urlSession = _urlSession
        let _dialogManager = SpecDialogManager()
        self.dialogManager = _dialogManager
        let locationServices = SpecLocationServices()
        let locationAuthorizationStatus = SpecLocationAuthorizationStatus()
        let locationManagerFactory = SpecLocationManagerFactory(dialogManager: dialogManager,
                                                                userLocation: userLocation,
                                                                locationServices: locationServices,
                                                                locationAuthorizationStatus: locationAuthorizationStatus)
        let appDelegate = SpecAppDelegate(sharedApplication: sharedApplication,
                                          dateProvider: dateProvider,
                                          timeZoneProvider: timeZoneProvider,
                                          urlSession: urlSession,
                                          locationManagerFactory: locationManagerFactory)
        return AppDelegateBundle(appDelegate: appDelegate,
                                 temporarilyStrong: [urlSession, locationManagerFactory, dialogManager])
    }
}
