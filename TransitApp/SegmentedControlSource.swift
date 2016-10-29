import Foundation

class SegmentedControlSource {

    let segments: [Segment]
    var selectedIndex: Int
    weak var delegate: SegmentedControlSourceDelegate?
    private let segmentTitles = ["COUP", "Door2Door"]
    private let mapSourceManager: MapSourceManager

    struct Segment {
        let index: Int
        let title: String
    }

    init(mapSourceManager: MapSourceManager) {
        self.mapSourceManager = mapSourceManager
        segments = segmentTitles.enumerated().map(Segment.init)
        selectedIndex = mapSourceManager.source == .coup ? 0 : 1
    }

    @objc
    func selectIndex(_ index: Int) {
        selectedIndex = index
        let source: MapSourceManager.Source = selectedIndex == 0 ? .coup : .door2door
        delegate?.didUpdate(source: source)
    }
    
}

protocol SegmentedControlSourceDelegate: class {
    func didUpdate(source: MapSourceManager.Source)
}
