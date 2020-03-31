import Foundation

@propertyWrapper
class UserDefaultsWrapper<T: Equatable> {
    private let key: String
    private let defaultValue: T

    public init(wrappedValue: T, _ key: String) {
        self.defaultValue = wrappedValue
        self.key = key
    }

    public var wrappedValue: T {
        get { return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }

    public var projectedValue: String { key }
}
