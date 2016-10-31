import Quick
import Nimble
@testable import TransitApp

class MapViewControllerCacheSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        var subject: MapViewControllerCache!

        beforeEach {
            subject = MapViewControllerCache()
        }

        describe("after adding a view controller for a key") {
            let theKey = MapSourceManager.Source.coup
            let theViewController = UIViewController()

            beforeEach {
                subject.add(theViewController, for: theKey)
            }

            it("can get the view controller") {
                let result = subject.get(for: theKey)
                expect(result).to(equal(theViewController))
            }
        }

        describe("if the view controller is not retained by someone else") {
            let theKey = MapSourceManager.Source.coup

            beforeEach {
                let theViewController = UIViewController()
                subject.add(theViewController, for: theKey)
            }

            it("will not retain the view controller") {
                let result = subject.get(for: theKey)
                expect(result).to(beNil())
            }
        }
    }
}
