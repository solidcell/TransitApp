import MapKit
@testable import TransitApp

class SpecMKMapView : MKMapViewDelegateHaving {
    
    weak var delegate: MKMapViewDelegate?
    
    let bsMapView = MKMapView()

    func drag() {
        // TODO add some state to keep track of the tracking mode and
        // then only fire this if it actually changed
        // TODO what is the `animated` supposed to be?
        delegate?.mapView?(bsMapView, didChange: .none, animated: true)
    }
    
}
