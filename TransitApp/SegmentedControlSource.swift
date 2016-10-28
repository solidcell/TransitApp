import Foundation

class SegmentedControlSource {

    let segments: [Segment]
    private let segmentTitles = ["COUP", "Door2Door"]

    struct Segment {
        let index: Int
        let title: String
    }

    init() {
        segments = segmentTitles.enumerated().map(Segment.init)
    }

    lazy var selectedIndex: Int = {
        return 0
    }()

    @objc
    func selectIndex(_ index: Int) {
        selectedIndex = index
    }
    
}
