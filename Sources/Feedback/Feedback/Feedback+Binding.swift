import SwiftUI

public extension Binding {
    /// Specifies the feedback to perform when the binding value changes.
    /// - Parameter feedback: Feedback performed when the binding value changes.
    ///
    /// - Returns: A new binding.
    func feedback(_ feedback: AnyFeedback = .haptic(.selection)) -> Self {
        Binding(
            get: { wrappedValue },
            set: { newValue in
                withFeedback(feedback) { wrappedValue = newValue }
            }
        )
    }
}

public extension Binding where Value: BinaryFloatingPoint {
    /// Specifies the feedback to perform when the binding value changes.
    /// - Parameter feedback: Feedback performed when the binding value changes.
    /// - Parameter step: The step required to trigger a binding change
    ///
    /// - Returns: A new binding.
    func feedback(_ feedback: AnyFeedback = .haptic(.selection), step: Value) -> Self {
        Binding(
            get: { wrappedValue },
            set: { newValue in
                let oldValue = round(wrappedValue / step) * step
                let stepValue = round(newValue / step) * step
                
                if oldValue != stepValue {
                    withFeedback(feedback) { wrappedValue = newValue }
                } else {
                    wrappedValue = newValue
                }
            }
        )
    }
}

public extension Binding where Value: BinaryInteger {
    /// Specifies the feedback to perform when the binding value changes.
    /// - Parameter feedback: Feedback performed when the binding value changes.
    /// - Parameter step: The step required to trigger a binding change
    ///
    /// - Returns: A new binding.
    func feedback(_ feedback: AnyFeedback = .haptic(.selection), step: Value) -> Self {
        Binding(
            get: { wrappedValue },
            set: { newValue in
                let oldValue = wrappedValue / step * step
                let stepValue = newValue / step * step
                
                if oldValue != stepValue {
                    withFeedback(feedback) { wrappedValue = newValue }
                } else {
                    wrappedValue = newValue
                }
            }
        )
    }
}
