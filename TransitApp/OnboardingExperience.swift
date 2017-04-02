import UIKitFringes

class OnboardingExperience {

    private let userDefaults: UserDefaulting
    private let hasSeenExperienceKey = "hasSeenExperienceKey"
    
    init(userDefaults: UserDefaulting) {
        self.userDefaults = userDefaults
    }

    var experience: Bool {
        if !userDefaults.bool(forKey: hasSeenExperienceKey) {
            userDefaults.set(true, forKey: hasSeenExperienceKey)
            return true
        }
        return false
    }
}
