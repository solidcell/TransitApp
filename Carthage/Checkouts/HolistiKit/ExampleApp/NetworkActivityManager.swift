import Foundation
import UIKitFringes

class NetworkActivityManager {

    struct Activity {
        fileprivate let uuid = UUID()
        fileprivate let manager: NetworkActivityManager

        func finish() {
            manager.activityFinished(self)
        }
    }

    private let sharedApplication: ApplicationProtocol
    private var activities = [Activity]()

    init(sharedApplication: ApplicationProtocol) {
        self.sharedApplication = sharedApplication
    }

    func activityStarted() -> Activity {
        sharedApplication.isNetworkActivityIndicatorVisible = true
        let activity = Activity(manager: self)
        activities.append(activity)
        return activity
    }

    func activityFinished(_ activity: Activity) {
        guard let index = activities.index(of: activity) else { return }
        activities.remove(at: index)
        if activities.isEmpty {
            sharedApplication.isNetworkActivityIndicatorVisible = false
        }
    }
}

extension NetworkActivityManager.Activity: Equatable { }

func ==(lhs: NetworkActivityManager.Activity, rhs: NetworkActivityManager.Activity) -> Bool {
    return lhs.uuid == rhs.uuid
}
