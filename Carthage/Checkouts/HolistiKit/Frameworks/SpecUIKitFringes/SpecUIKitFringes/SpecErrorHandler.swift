/*
 During normal usage of Spec classes, incorrect usage should fatalError 
 immediately. If you're trying to do something that wouldn't be possible,
 or something that wouldn't actually be happening, we should know right 
 away. However, in testing this fatalError behavior itself, we need to be 
 able to log these errors instead of fatal erroring.

 Note: When testing for these errors, ensure that the tests test nothing 
 further afterward, since a fatalError would normally halt operation.
 However, if logging instead of fatal erroring, execution continues. So,
 any state after the error is unreliable.
 */

class SpecErrorHandler {

    var recordedError: FatalError?
    private var recordingMode = false

    enum FatalError {
        case appSwitcherNotOpen
        case noScreenshotInAppSwitcher
        case notOnSpringBoard
        case noDialog
        case notAValidDialogResponse
        case noSuchURLRequestInProgress

        var message: String {
            switch self {
            case .appSwitcherNotOpen:
                return "The user is not in the App Switcher"
            case .noScreenshotInAppSwitcher:
                return "The screenshot is not in the App Switcher"
            case .notOnSpringBoard:
                return "The user is not on the SpringBoard"
            case .noDialog:
                return "There is no dialog visible"
            case .notAValidDialogResponse:
                return "The dialog has no such available response"
            case .noSuchURLRequestInProgress:
                return "There was no such URL request in the app at the moment"
            }
        }
    }

    func error(_ error: FatalError) {
        if recordingMode {
            record(error)
        } else {
            fatalError(error.message)
        }
    }

    private func record(_ error: FatalError) {
        if recordedError == nil {
            recordedError = error
        }
    }

    func fatalErrorsOff(_ block: @escaping () -> Void) {
        let initialMode = recordingMode
        recordingMode = true
        block()
        recordingMode = initialMode
    }
}
