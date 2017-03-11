import MapKit

extension MKCoordinateRegion: Equatable {}
public func ==(lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
    return lhs.center == rhs.center
        && lhs.span == rhs.span
}
