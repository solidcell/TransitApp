import UIKit

class MapViewControllerCache {

    private var cache = [Int : Weak<UIViewController>]()

    func get(for source: MapSourceManager.Source) -> UIViewController? {
        return cache[source.rawValue]?.value
    }

    func add(_ mapViewController: UIViewController, for source: MapSourceManager.Source) {
        cache[source.rawValue] = Weak(mapViewController)
    }
    
}

private class Weak<T: AnyObject>: NSObject {
    public private(set) weak var value: T?

    public init(_ value: T?) {
        self.value = value
    }
}
