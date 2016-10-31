import UIKit
import MapKit

class MapSelectorViewController: UIViewController {

    var mapAnnotationProvider: MapAnnotationProvider!
    var mapOverlayProvider: MapOverlayProvider!
    var initialCoordinateRegion: MKCoordinateRegion!
    var mapViewDelegate: MKMapViewDelegate!
    var segmentedControlSource: SegmentedControlSource!

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureMapView()
        configureSegmentControl()
    }

    private func configureMapView() {
        mapView.delegate = mapViewDelegate
        mapView.setRegion(initialCoordinateRegion, animated: true)
        configureMapAnnotations()
        configureMapOverlays()
    }

    private func configureMapOverlays() {
        mapOverlayProvider.delegate = self
    }

    private func configureMapAnnotations() {
        mapAnnotationProvider.delegate = self
    }

    private func configureSegmentControl() {
        // set the background color
        segmentedControl.backgroundColor = UIColor.white
        segmentedControl.layer.cornerRadius = 4.0
        segmentedControl.clipsToBounds = true
        // insert the segments
        segmentedControl.removeAllSegments()
        segmentedControlSource.segments.enumerated().forEach { index, segment in
            segmentedControl.insertSegment(withTitle: segment.title,
                                           at: index,
                                           animated: false)
        }
        // set the initial selection
        segmentedControl.selectedSegmentIndex = segmentedControlSource.selectedIndex
        // update selection
        segmentedControl.addTarget(self,
                                   action: #selector(didChangeSegmentedControlValue(_:)),
                                   for: UIControlEvents.valueChanged)
    }

    func didChangeSegmentedControlValue(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        segmentedControlSource.selectIndex(index)
    }
    
}

extension MapSelectorViewController: MapOverlayProviderDelegate {

    func didUpdate(overlays: [MKOverlay]) {
        // remove current overlays
        let currentOverlays = mapView.overlays
        mapView.removeOverlays(currentOverlays)
        // add new overlays
        overlays.forEach(mapView.add)
    }
    
}

extension MapSelectorViewController: MapAnnotationProviderDelegate {

    func didUpdate(annotations: [MKAnnotation]) {
        // remove current annotations
        let currentAnnotations = mapView.annotations
        mapView.removeAnnotations(currentAnnotations)
        // add new annotations
        annotations.forEach(mapView.addAnnotation)
    }

}

// MARK: Creation
extension MapSelectorViewController {
    
    private static var storyboardName = "MapSelectorViewController"

    // Using a Storyboard, rather than a NIB, allows us access
    // to top/bottom layout guides in Interface Builder
    class func createFromStoryboard(mapAnnotationProvider: MapAnnotationProvider,
                                    mapOverlayProvider: MapOverlayProvider,
                                    initialCoordinateRegion: MKCoordinateRegion,
                                    mapViewDelegate: MKMapViewDelegate,
                                    segmentedControlSource: SegmentedControlSource) -> MapSelectorViewController {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! MapSelectorViewController
        vc.mapAnnotationProvider = mapAnnotationProvider
        vc.mapOverlayProvider = mapOverlayProvider
        vc.initialCoordinateRegion = initialCoordinateRegion
        vc.mapViewDelegate = mapViewDelegate
        vc.segmentedControlSource = segmentedControlSource
        return vc
    }
    
}

