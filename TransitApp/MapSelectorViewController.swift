import UIKit
import MapKit

class MapSelectorViewController: UIViewController {

    var segmentedControlSource: SegmentedControlSource!
    weak var delegate: MapSelectorViewControllerDelegate?

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var mapContainerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate?.viewDidLoad()

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

    func add(mapViewController: UIViewController) {
        // add child view controller, or nothing if already a child view controller
        self.addChildViewController(mapViewController)
        // add subview, or move to top if already a subview
        self.mapContainerView.addSubview(mapViewController.view)
        mapViewController.view.frame = self.mapContainerView.bounds
        mapViewController.didMove(toParentViewController: self)
    }
    
}

// MARK: Creation
extension MapSelectorViewController {
    
    private static var storyboardName = "MapSelectorViewController"

    // Using a Storyboard, rather than a NIB, allows us access
    // to top/bottom layout guides in Interface Builder
    class func createFromStoryboard(delegate: MapSelectorViewControllerDelegate,
                                    segmentedControlSource: SegmentedControlSource) -> MapSelectorViewController {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! MapSelectorViewController
        vc.delegate = delegate
        vc.segmentedControlSource = segmentedControlSource
        return vc
    }
    
}

