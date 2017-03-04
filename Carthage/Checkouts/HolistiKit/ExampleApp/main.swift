import UIKit

let isRunningTests = NSClassFromString("XCTestCase") != nil

let appDelegateClassString: String? = isRunningTests ? nil : NSStringFromClass(AppDelegate.self)

let argsCount = Int(CommandLine.argc)
let argsRawPointer = UnsafeMutableRawPointer(CommandLine.unsafeArgv)
let args = argsRawPointer.bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: argsCount)

UIApplicationMain(CommandLine.argc, args, nil, appDelegateClassString)
