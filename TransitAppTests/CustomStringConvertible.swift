import MapKit

extension MKUserTrackingMode : CustomStringConvertible {

    public var description: String {
        switch self {
        case .none: return "none"
        case .follow: return "follow"
        case .followWithHeading: return "followWithHeading"
        }
    }

}
