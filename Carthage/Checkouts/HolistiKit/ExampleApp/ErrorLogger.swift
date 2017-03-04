class ErrorLogger: ErrorLogging {

    func log(_ message: String) {
        print(message)
    }
}

protocol ErrorLogging {

    func log(_ message: String)
}
