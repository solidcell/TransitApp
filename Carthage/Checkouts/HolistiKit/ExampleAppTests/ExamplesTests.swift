import XCTest

class ExamplesTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        XCTAssertEqual(examplesUI.title, "Examples")
    }

    func test_rowsAreCorrectlyConfigured() {
        tapAppIcon()
        let expectedRows: [(String, UITableViewCellAccessoryType)] = [
            ("Date", .disclosureIndicator),
            ("Timer", .disclosureIndicator),
            ("URLSession", .disclosureIndicator),
            ("UIViewController", .disclosureIndicator),
            ("CLLocationManager", .disclosureIndicator)
        ]
        XCTAssertEqual(examplesUI.numberOfRows, expectedRows.count)
        expectedRows.enumerated().forEach { index, row in
            XCTAssertEqual(examplesUI.title(forRow: index), row.0)
            XCTAssertEqual(examplesUI.accessoryIndicator(forRow: index), row.1)
        }
    }

    func test_canNavigateToTheDatePage() {
        tapAppIcon()
        examplesUI.tapDateRow()
        XCTAssertNotNil(dateUI)
    }
}
