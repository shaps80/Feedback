import SwiftUI
import Combine

internal extension Backport where Wrapped: View {
    @ViewBuilder
    func onChange<Value: Equatable>(of value: Value, perform action: @escaping (Value) -> Void) -> some View {
        if #available(iOS 14, macOS 11, *) {
            content.onChange(of: value, perform: action)
        } else {
            content.modifier(ChangeModifier(value: value, action: action))
        }
    }

}

private struct ChangeModifier<Value: Equatable>: ViewModifier {
    let value: Value
    let action: (Value) -> Void

    @State var oldValue: Value?

    init(value: Value, action: @escaping (Value) -> Void) {
        self.value = value
        self.action = action
        _oldValue = .init(initialValue: value)
    }

    func body(content: Content) -> some View {
        content
            .onReceive(Just(value)) { newValue in
                guard newValue != oldValue else { return }
                action(newValue)
                oldValue = newValue
            }
    }
}
