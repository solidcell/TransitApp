import UIKit

extension UIView {
    
    class func performWithAnimation(_ enabled: Bool, actions: () -> Void) {
        let initial = areAnimationsEnabled
        
        setAnimationsEnabled(enabled)
        actions()
        
        setAnimationsEnabled(initial)
    }
}
