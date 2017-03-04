@testable import SpecUIKitFringes

class RecordingSpecApplicationDelegate: SpecApplicationDelegateProtocol {
    
    public var window: SpecWindow!
    
    enum Event {
        case applicationDidLaunch
        case applicationWillResignActive
        case applicationDidEnterBackground
        case applicationWillEnterForeground
        case applicationDidBecomeActive
        case applicationWillTerminate
    }

    private(set) var events = [Event]()

    func clearEvents() {
        events.removeAll()
    }

    func applicationDidLaunch() {
        add(event: .applicationDidLaunch)
    }
    
    func applicationWillResignActive() {
        add(event: .applicationWillResignActive)
    }
    
    func applicationDidEnterBackground() {
        add(event: .applicationDidEnterBackground)
    }
    
    func applicationWillEnterForeground() {
        add(event: .applicationWillEnterForeground)
    }
    
    func applicationDidBecomeActive() {
        add(event: .applicationDidBecomeActive)
    }
    
    func applicationWillTerminate() {
        add(event: .applicationWillTerminate)
    }
    
    private func add(event: Event) {
        events.append(event)
    }
}
