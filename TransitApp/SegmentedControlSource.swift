import Foundation

class SegmentedControlSource {

    let segments: [Segment]
    var selectedIndex: Int
    private(set) weak var delegate: SegmentedControlSourceDelegate?
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
        self.delegate = mapSourceManager
        segments = mapSourceManager.sources.map(Segment.init)
        selectedIndex = segments.index(where: { $0.source == mapSourceManager.source})!
    }

    func selectIndex(_ index: Int) {
        selectedIndex = index
        let source = segments[index].source
        delegate?.didSelect(source: source)
    }
    
}

protocol SegmentedControlSourceDelegate: class {
    func didSelect(source: MapSourceManager.Source)
}
