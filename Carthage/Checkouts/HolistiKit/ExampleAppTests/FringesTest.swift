import XCTest
import UIKitFringes
import SpecUIKitFringes
@testable import ExampleApp

class FringesTest: XCTestCase {

    fileprivate var system: FringesSpecSystem!
    
    override func setUp() {
        super.setUp()
        system = FringesSpecSystem()
    }
}

// MARK: App Launching, Backgrounding, Killing, etc.
extension FringesTest {

    func tapAppIcon() {
        system.tapAppIcon()
    }
}

// MARK: Time
extension FringesTest {

    func progress(seconds: UInt) {
        dateProvider.progress(seconds: seconds)
    }

    private var dateProvider: SpecDateProvider {
        return system.dateProvider
    }
}

// MARK: Network
extension FringesTest {

    func respond(to urlRequest: String, withHTML html: String) {
        let data = NetworkResponseCreator.data(from: html)
        let url = URL(string: urlRequest)!
        let urlResponse = URLResponse(url: url,
                                      mimeType: "text/html",
                                      expectedContentLength: data.count,
                                      textEncodingName: "utf-8")
        respond(to: urlRequest, with: .success(data, urlResponse))
    }

    func respond(to urlRequest: String, withJSON json: [String:Any]) {
        let data = NetworkResponseCreator.data(from: json)
        let url = URL(string: urlRequest)!
        let urlResponse = URLResponse(url: url,
                                      mimeType: "application/json",
                                      expectedContentLength: data.count,
                                      textEncodingName: nil)
        respond(to: urlRequest, with: .success(data, urlResponse))
    }

    private func respond(to urlRequest: String, with response: SpecURLSession.Response) {
        urlSession.respond(to: urlRequest, with: response)
    }

    private var urlSession: SpecURLSession {
        return system.urlSession
    }
}

// MARK: CLLocationManager
extension FringesTest {

    var visibleDialog: SpecDialogManager.DialogIdentifier? {
        return dialogManager.visibleDialog
    }
    
    func dialogResponse(_ response: SpecDialogManager.Response) {
        return dialogManager.tap(response)
    }

    private var dialogManager: SpecDialogManager {
        return system.dialogManager
    }
}

// MARK: CLLocationManager
extension FringesTest {

    var userLocation: SpecUserLocation {
        return system.userLocation
    }
}

// MARK: Shared Application
extension FringesTest {

    var networkActivityIndicatorIsVisible: Bool {
        return sharedApplication.isNetworkActivityIndicatorVisible
    }

    private var sharedApplication: ApplicationProtocol {
        return system.sharedApplication
    }
}

// MARK: Top View Controller Accessing
extension FringesTest {

    var window: SpecWindow {
        guard let window = system.appDelegate.window else {
            fatalError("There is no window. Did you forget to launch the app?")
        }
        return window
    }

    var examplesUI: SpecExamplesViewControllerUI! {
        return topViewController(as: SpecExamplesViewControllerUI.self)
    }

    var dateUI: SpecDateViewControllerUI! {
        return topViewController(as: SpecDateViewControllerUI.self)
    }

    var timerUI: SpecTimerViewControllerUI! {
        return topViewController(as: SpecTimerViewControllerUI.self)
    }

    var urlSessionUI: SpecURLSessionViewControllerUI! {
        return topViewController(as: SpecURLSessionViewControllerUI.self)
    }

    var uiViewControllerUI: SpecUIViewControllerViewControllerUI! {
        return topViewController(as: SpecUIViewControllerViewControllerUI.self)
    }

    var clLocationManagerUI: SpecCLLocationManagerViewControllerUI! {
        return topViewController(as: SpecCLLocationManagerViewControllerUI.self)
    }

    var navigationController: SpecNavigationControllerUI {
        guard let navigationController = window.topViewController.navigationController else {
            fatalError("The top view controller is not inside a navigation controller.")
        }
        return navigationController
    }

    private func topViewController<I>(as interface: I.Type) -> I {
        if let top = window.topViewController as? I {
            return top
        }
        let currentViewControllerStack = window.viewControllerStack
            .enumerated()
            .map { "[\($0)] [\($1)]" }
            .joined(separator: "\n")
        fatalError("\nThe top view controller was not an instance of [\(I.self)]\n" +
            "This is the current view controller stack:\n" +
            "\(currentViewControllerStack)\n" +
            "[-] Window\n")
    }
}
