public protocol SpecApplicationDelegateProtocol {
    
    var window: SpecWindow! { get }
    
    func applicationDidLaunch()
    func applicationWillResignActive()
    func applicationDidEnterBackground()
    func applicationWillEnterForeground()
    func applicationDidBecomeActive()
    func applicationWillTerminate()
}

public extension SpecApplicationDelegateProtocol {
    
    func applicationDidLaunch() { }
    func applicationWillResignActive() { }
    func applicationDidEnterBackground() { }
    func applicationWillEnterForeground() { }
    func applicationDidBecomeActive() { }
    func applicationWillTerminate() { }
}
