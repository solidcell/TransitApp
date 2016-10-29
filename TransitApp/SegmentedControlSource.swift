import Foundation

class SegmentedControlSource {

    let segments: [Segment]
    var selectedIndex: Int
    weak var delegate: SegmentedControlSourceDelegate?
    private let mapSourceManager: MapSourceManager

    struct Segment {
        let source: MapSourceManager.Source

        var title: String {
            switch source {
            case .coup: return "COUP"
            case .door2door: return "Door2Door"
            }
        }
    }

    init(mapSourceManager: MapSourceManager) {
        self.mapSourceManager = mapSourceManager
        segments = mapSourceManager.sources.map(Segment.init)
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
