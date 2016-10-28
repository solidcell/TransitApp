import UIKit
import MapKit

class MapViewController: UIViewController {

    var annotations: [MapAnnotation]!
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
        annotations.forEach(mapView.addAnnotation)
        mapView.setRegion(initialCoordinateRegion, animated: true)
    }

    private func configureSegmentControl() {
        // set the background color
        segmentedControl.backgroundColor = UIColor.white
        segmentedControl.layer.cornerRadius = 4.0
        segmentedControl.clipsToBounds = true
        // insert the segments
        segmentedControl.removeAllSegments()
        segmentedControlSource.segments.forEach { segment in
            segmentedControl.insertSegment(withTitle: segment.title,
                                           at: segment.index,
                                           animated: false)
        }
        // set the initial selection
        segmentedControl.selectedSegmentIndex = segmentedControlSource.selectedIndex
        // update selection
        segmentedControl.addTarget(segmentedControlSource,
                                   action: #selector(SegmentedControlSource.selectIndex(_:)),
                                   for: UIControlEvents.valueChanged)
    }
    
}

// MARK: Creation
extension MapViewController {
    
    private static var storyboardName = "MapViewController"

    // Using a Storyboard, rather than a NIB, allows us access
    // to top/bottom layout guides in Interface Builder
    class func createFromStoryboard(annotations: [MapAnnotation],
                                    initialCoordinateRegion: MKCoordinateRegion,
                                    mapViewDelegate: MKMapViewDelegate,
                                    segmentedControlSource: SegmentedControlSource) -> MapViewController {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! MapViewController
        vc.annotations = annotations
        vc.initialCoordinateRegion = initialCoordinateRegion
        vc.mapViewDelegate = mapViewDelegate
        vc.segmentedControlSource = segmentedControlSource
        return vc
    }
    
}

