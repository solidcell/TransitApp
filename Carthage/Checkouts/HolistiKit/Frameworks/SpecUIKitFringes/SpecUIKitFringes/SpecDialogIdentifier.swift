extension SpecDialogManager {
    
    public enum LocationManagerIdentifier {
        // "Allow "<AppName>" to access your location while you use the app?"
        // "<message you have set in Info.plist for NSLocationWhenInUseUsageDescription>"
        // [Don't Allow] [Allow]
        case requestAccessWhileInUse
        //     When status is notDetermined:
        // "Allow "<AppName>" to access your location even when you are not using the app?"
        // "<message you have set in Info.plist for NSLocationAlwaysUsageDescription>"
        // [Don't Allow] [Allow]
        //     When status is already authorizedWhenInUse:
        // "Allow "<AppName>" to also access your location even when you are not using the app?"
        // "<message you have set in Info.plist for NSLocationAlwaysUsageDescription>"
        // [Cancel] [Allow]
        case requestAccessAlways
        // "Turn On Location Services to Allow "<AppName>" to Determine Your Location"
        // [Settings] [Cancel]
        case requestJumpToLocationServicesSettings
    }

    public enum DialogIdentifier {
        case locationManager(LocationManagerIdentifier)
    }
}

extension SpecDialogManager.DialogIdentifier: Equatable { }
public func ==(lhs: SpecDialogManager.DialogIdentifier, rhs: SpecDialogManager.DialogIdentifier) -> Bool {
    switch (lhs, rhs) {
        case (.locationManager(let subL), .locationManager(let subR)):
            return subL == subR
    }
}
