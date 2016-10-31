import UIKit

class MapViewControllerCache {

    private var cache = [Int : Weak<UIViewController>]()

    func get(_ source: MapSourceManager.Source, factory: () -> UIViewController) -> UIViewController {
        return get(for: source) ?? add(factory(), for: source)
    }

    private func get(for source: MapSourceManager.Source) -> UIViewController? {
        return cache[source.rawValue]?.value
    }

    private func add(_ mapViewController: UIViewController, for source: MapSourceManager.Source) -> UIViewController {
        cache[source.rawValue] = Weak(mapViewController)
        return mapViewController
    }
    
}

private class Weak<T: AnyObject>: NSObject {
    public private(set) weak var value: T?

    public init(_ value: T?) {
        self.value = value
    }
}
