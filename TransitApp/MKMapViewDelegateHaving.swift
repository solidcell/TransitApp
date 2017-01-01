import MapKit

protocol MKMapViewDelegateHaving : class {
    
    weak var delegate: MKMapViewDelegate? { get set }
    
}

extension MKMapView : MKMapViewDelegateHaving { }
