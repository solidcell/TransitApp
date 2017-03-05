@testable import TransitApp

class SpecFetchTimer: FetchTiming {

    var block: (() -> Void)?

    func start(block: @escaping () -> Void) {
        self.block = block
    }

    func fire() {
        block?()
    }

}
