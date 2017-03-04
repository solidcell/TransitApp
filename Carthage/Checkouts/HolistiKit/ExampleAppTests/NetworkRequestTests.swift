import XCTest
@testable import ExampleApp

class URLSessionTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        examplesUI.tapURLSessionRow()
        XCTAssertEqual(urlSessionUI.title, "URLSession")
    }

    func test_jsonIsShownUponSuccess() {
        tapAppIcon()
        examplesUI.tapURLSessionRow()
        XCTAssertEqual(urlSessionUI.dataLabel,
                       SpecURLSessionViewController.DataLabel(text: "", animated: false))
        urlSessionUI.tapRequestJSON()
        respond(to: "https://httpbin.org/delay/3", withJSON: ["Some key" : "Some value"])
        XCTAssertEqual(urlSessionUI.dataLabel, 
                       SpecURLSessionViewController.DataLabel(text: "[\"Some key\": Some value]", animated: true))
    }

    func test_htmlIsShownUponSuccess() {
        tapAppIcon()
        examplesUI.tapURLSessionRow()
        XCTAssertEqual(urlSessionUI.dataLabel,
                       SpecURLSessionViewController.DataLabel(text: "", animated: false))
        urlSessionUI.tapRequestHTML()
        respond(to: "https://httpbin.org/html", withHTML: "<p>hello world</p>")
        XCTAssertEqual(urlSessionUI.dataLabel,
                       SpecURLSessionViewController.DataLabel(text: "<p>hello world</p>", animated: true))
    }

    func test_theNetworkActivityIndicatorIsShown() {
        tapAppIcon()
        XCTAssertFalse(networkActivityIndicatorIsVisible)
        examplesUI.tapURLSessionRow()
        urlSessionUI.tapRequestJSON()
        XCTAssertTrue(networkActivityIndicatorIsVisible)
        respond(to: "https://httpbin.org/delay/3", withJSON: [:])
        XCTAssertFalse(networkActivityIndicatorIsVisible)
    }

    func test_theNetworkActivityIndicatorIsRemovedWhenTappingBack() {
        tapAppIcon()
        XCTAssertFalse(networkActivityIndicatorIsVisible)
        examplesUI.tapURLSessionRow()
        urlSessionUI.tapRequestJSON()
        XCTAssertTrue(networkActivityIndicatorIsVisible)
        navigationController.tapBack()
        XCTAssertFalse(networkActivityIndicatorIsVisible)
    }
}
