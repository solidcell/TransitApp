import XCTest

class DateTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        examplesUI.tapDateRow()
        XCTAssertEqual(dateUI.title, "Date")
    }

    func test_showsTheCurrentTime() {
        tapAppIcon()
        progress(seconds: 9)
        examplesUI.tapDateRow()
        XCTAssertEqual(dateUI.dateLabel, "21:00:09 22 August 2016")
    }
    
    func test_canExit() {
        tapAppIcon()
        examplesUI.tapDateRow()
        XCTAssertNotNil(dateUI)
        navigationController.tapBack()
        XCTAssertNotNil(examplesUI)
    }

    func test_updatesTheTimeUponViewLoad() {
        tapAppIcon()
        progress(seconds: 2)
        examplesUI.tapDateRow()
        XCTAssertEqual(dateUI.dateLabel, "21:00:02 22 August 2016")
        navigationController.tapBack()
        progress(seconds: 1)
        examplesUI.tapDateRow()
        XCTAssertEqual(dateUI.dateLabel, "21:00:03 22 August 2016")
    }
}
