import XCTest

class TimerTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        examplesUI.tapTimerRow()
        XCTAssertEqual(timerUI.title, "Timer")
    }

    func test_testLabelUpdatesAsTimePasses() {
        tapAppIcon()
        examplesUI.tapTimerRow()
        XCTAssertEqual(timerUI.dateLabel, "21:00:00 22 August 2016")
        progress(seconds: 2)
        XCTAssertEqual(timerUI.dateLabel, "21:00:02 22 August 2016")
        progress(seconds: 3)
        XCTAssertEqual(timerUI.dateLabel, "21:00:05 22 August 2016")
    }
}
