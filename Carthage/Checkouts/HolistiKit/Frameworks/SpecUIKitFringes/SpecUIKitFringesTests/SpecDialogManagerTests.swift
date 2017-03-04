import XCTest
@testable import SpecUIKitFringes

class SpecDialogManagerTests: XCTestCase {

    var subject: SpecDialogManager!
    var errorHandler: SpecErrorHandler!
    
    override func setUp() {
        super.setUp()
        errorHandler = SpecErrorHandler()
        subject = SpecDialogManager(errorHandler: errorHandler)
    }

    func test_addingADialog() {
        subject.addDialog(TestDialog())
        XCTAssertEqual(subject.visibleDialog, .locationManager(.requestAccessAlways))
    }

    func test_tappingOnAButton() {
        let testDialog = TestDialog()
        subject.addDialog(testDialog)
        subject.tap(.allow)
        XCTAssertEqual(testDialog.response, .allow)
        XCTAssertNil(subject.visibleDialog)
    }

    func test_tappingOnANonExistentButton() {
        let testDialog = TestDialog()
        subject.addDialog(testDialog)
        errorHandler.fatalErrorsOff {
            self.subject.tap(.dontAllow)
        }
        XCTAssertEqual(errorHandler.recordedError, .notAValidDialogResponse)
    }
}

public class TestDialog: SpecDialog {

    var response: SpecDialogManager.Response?
    public let identifier: SpecDialogManager.DialogIdentifier = .locationManager(.requestAccessAlways)
    private let acceptableResponses: [SpecDialogManager.Response]

    init(acceptableResponses: [SpecDialogManager.Response] = [.allow]) {
        self.acceptableResponses = acceptableResponses
    }

    public func responded(with response: SpecDialogManager.Response) -> Bool {
        if !acceptableResponses.contains(response) { return false }
        self.response = response
        return true
    }
}
