open class SpecSystem {

    private let errorHandler: SpecErrorHandler
    
    public init() {
        self.errorHandler = SpecErrorHandler()
    }
    
    init(errorHandler: SpecErrorHandler) {
        self.errorHandler = errorHandler
    }

    public private(set) var appDelegate: SpecApplicationDelegateProtocol!
    private var locations: [Location] = [.springBoard]
    private var screenshotInAppSwitcher = false

    private enum Location {
        case springBoard
        case app
        case appSwitcher
    }

    public struct AppDelegateBundle {
        let appDelegate: SpecApplicationDelegateProtocol
        let temporarilyStrong: [Any]

        public init(appDelegate: SpecApplicationDelegateProtocol,
                    temporarilyStrong: [Any]) {
            self.appDelegate = appDelegate
            // this holds a strong reference of dependencies long enough
            // for applicationDidLaunch to be called, and for the actual
            // dependent objects to get the dependencies. Neither
            // AppDelegate nor the SpecSystem should retain them.
            self.temporarilyStrong = temporarilyStrong
        }
    }

    open func createAppDelegateBundle() -> AppDelegateBundle {
        fatalError("This class is abstract")
    }
    
    public func tapAppIcon() {
        errorIfNotOnSpringBoard()
        if let appDelegate = appDelegate {
            appDelegate.applicationWillEnterForeground()
            appDelegate.applicationDidBecomeActive()
        } else {
            launch()
        }
    }

    private func launch() {
        let newAppDelegateBundle = createAppDelegateBundle()
        appDelegate = newAppDelegateBundle.appDelegate
        appDelegate.applicationDidLaunch()
        appDelegate.applicationDidBecomeActive()
        screenshotInAppSwitcher = true
        move(to: .app)
    }

    public func tapHomeButton() {
        switch location {
        case .appSwitcher:
            anyHomeButtonTapInAppSwitcher()
        case .app:
            appDelegate.applicationWillResignActive()
            appDelegate.applicationDidEnterBackground()
            move(to: .springBoard)
        case .springBoard:
            break;
        }
    }

    private func anyHomeButtonTapInAppSwitcher() {
        if let appDelegate = appDelegate, cameFrom(.app) {
            appDelegate.applicationDidBecomeActive()
            move(to: .app)
        } else {
            move(to: .springBoard)
        }
    }

    public func doubleTapHomeButton() {
        switch location {
        case .appSwitcher:
            anyHomeButtonTapInAppSwitcher()
        case .app:
            appDelegate.applicationWillResignActive()
            move(to: .appSwitcher)
        case .springBoard:
            move(to: .appSwitcher)
        }
    }

    public func tapAppScreenshot() {
        errorIfAppSwitcherIsNotOpen()
        errorIfNoScreenshotInAppSwitcher()
        if let appDelegate = appDelegate {
            appDelegate.applicationDidBecomeActive()
        } else {
        }
    }

    public func swipeUpAppScreenshot() {
        appDelegate.applicationDidEnterBackground()
        appDelegate.applicationWillTerminate()
        appDelegate = nil
        screenshotInAppSwitcher = false
    }

    private func move(to location: Location) {
        locations.append(location)
    }

    private func at(_ location: Location) -> Bool {
        return self.location == location
    }

    private var location: Location {
        return locations.last!
    }

    private func cameFrom(_ location: Location) -> Bool {
        return lastLocation == location
    }

    private var lastLocation: Location {
        return locations[locations.count - 2]
    }

    private func errorIfNotOnSpringBoard() {
        if !at(.springBoard) { errorHandler.error(.notOnSpringBoard) }
    }

    private func errorIfAppSwitcherIsNotOpen() {
        if !at(.appSwitcher) { errorHandler.error(.appSwitcherNotOpen) }
    }

    private func errorIfNoScreenshotInAppSwitcher() {
        if !screenshotInAppSwitcher { errorHandler.error(.noScreenshotInAppSwitcher) }
    }
}
