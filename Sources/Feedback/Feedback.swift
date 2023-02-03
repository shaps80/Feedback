import SwiftUI
import CoreHaptics

/// Represents a feedback type
public protocol Feedback {
    func perform() async
}

/// Returns the result of recomputing the view's body with the provided animation.
/// - Parameters:
///   - feedback: The feedback to perform when the body is called
///   - body: The content of this value will be called alongside the feedback
public func withFeedback<Result>(_ feedback: AnyFeedback = .haptic(.selection), _ body: () throws -> Result) rethrows -> Result {
    Task { await feedback.perform() }
    return try body()
}

public extension View {
    /// Attaches some feedback to this view when the specified value changes
    /// - Parameters:
    ///   - feedback: The feedback to perform when the value changes
    ///   - value: The value to observe for changes
    func feedback<V>(_ feedback: AnyFeedback, value: V) -> some View where V: Equatable {
        modifier(FeedbackModifier(feedback: feedback, value: value))
    }
}

extension ModifiedContent: Feedback where Content: Feedback, Modifier: Feedback {
    /// Performs the specified feedback and any associated feedback (via combined)
    public func perform() async {
        async let c: Void = content.perform()
        async let m: Void = modifier.perform()
        _ = await (c, m)
    }
}

public extension Feedback {
    /// Combines this feedback with another
    /// - Parameter feedback: The feedback to combine with this feedback
    /// - Returns: The combined feedback
    func combined(with feedback: AnyFeedback) -> AnyFeedback {
        AnyFeedback(ModifiedContent(content: self, modifier: feedback))
    }
}

internal struct FeedbackModifier<V: Equatable>: ViewModifier {
    let feedback: any Feedback
    let value: V

    func body(content: Content) -> some View {
        content
            .backport.onChange(of: value) { value in
                Task { await feedback.perform() }
            }
    }
}
