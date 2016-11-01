import Foundation

// NOTE: This class is not tested.
//
// It's a simple wrapper around asynchronous timer code.
// If you change something here, be sure to test it manually.

class FetchTimer: FetchTiming {

    private let interval = 2.0
    private var timer: Timer?

    func start(block: @escaping () -> Void) {
        // invalidate an existing timer if one exists
        self.timer?.invalidate()
        // fire the first time immediately
        block()
        // set a timer for subsequent firing
        self.timer = Timer.scheduledTimer(timeInterval: interval,
                                          target: WeakTarget(block: block),
                                          selector: #selector(WeakTarget.execute),
                                          userInfo: nil,
                                          repeats: true)
    }

    deinit {
        self.timer?.invalidate()
    }

    class WeakTarget {
        
        private var block: (() -> Void)?

        init(block: @escaping () -> Void) {
            self.block = block
        }

        @objc func execute() {
            self.block?()
        }

    }

}

protocol FetchTiming {
    
    func start(block: @escaping () -> Void)
    
}
