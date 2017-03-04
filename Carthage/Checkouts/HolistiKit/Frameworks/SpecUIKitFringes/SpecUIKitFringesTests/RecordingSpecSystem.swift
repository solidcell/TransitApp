@testable import SpecUIKitFringes

class RecordingSpecSystem: SpecSystem {

    override func createAppDelegateBundle() -> SpecSystem.AppDelegateBundle {
        return SpecSystem.AppDelegateBundle(appDelegate: RecordingSpecApplicationDelegate(),
                                            temporarilyStrong: [])
    }
}
