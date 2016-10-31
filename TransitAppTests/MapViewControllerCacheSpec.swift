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

        describe("when getting a view controller for a key") {
            let theKey = MapSourceManager.Source.coup
            let theViewController = UIViewController()
            var returnedFromCreation: UIViewController?

            beforeEach {
                returnedFromCreation = subject.get(theKey) {
                    return theViewController
                }
            }

            it("returns the view controller when created") {
                expect(returnedFromCreation).to(equal(theViewController))
            }

            it("can get the cached view controller later") {
                let result = subject.get(theKey) { UIViewController() }
                expect(result).to(equal(theViewController))
            }
        }

        describe("if the view controller is not retained by someone else") {
            let theKey = MapSourceManager.Source.coup

            beforeEach {
                let theViewController = UIViewController()
                _ = subject.get(theKey) {
                    return theViewController
                }
            }

            it("will not retain the view controller") {
                let newViewController = UIViewController()
                let result = subject.get(theKey) { newViewController }
                expect(result).to(equal(newViewController))
            }
        }
    }
}
