import MapKit

extension MKCoordinateSpan: Equatable {}
public func ==(lhs: MKCoordinateSpan, rhs: MKCoordinateSpan) -> Bool {
    return lhs.latitudeDelta == rhs.latitudeDelta
        && lhs.longitudeDelta == rhs.longitudeDelta
}
