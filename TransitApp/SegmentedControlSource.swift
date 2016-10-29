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
        selectedIndex = segments.index(where: { $0.source == mapSourceManager.source})!
    }

    @objc
    func selectIndex(_ index: Int) {
        selectedIndex = index
        let source = segments[index].source
        delegate?.didUpdate(source: source)
    }
    
}

protocol SegmentedControlSourceDelegate: class {
    func didUpdate(source: MapSourceManager.Source)
}