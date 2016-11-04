extension Equatable {
    
    func isOneOf(_ otherValues: Self...) -> Bool {
        return otherValues.contains(self)
    }
    
}
