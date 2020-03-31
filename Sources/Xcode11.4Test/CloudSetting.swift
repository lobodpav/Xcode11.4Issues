import Foundation

/// A setting backed by the `NSUbiquitousKeyValueStore`
class CloudSetting<T: Equatable> {
    private let cloudListener: CloudListener
    private let notifier: (_ value: T?) -> (Void)
    let propertyName: String

    init(_ propertyName: String, notifier: @escaping (_ value: T?) -> (Void)) {
        self.propertyName = propertyName
        self.notifier = notifier
        self.cloudListener = CloudListener()

        cloudListener.listenForChanges(cloudSettingsChanged(keys:))
    }

    private func cloudSettingsChanged(keys: [String]) {
        print("!!!! Cloud settings changed: \(keys)")

        if keys.contains(propertyName) {
            notifier(NSUbiquitousKeyValueStore.default.object(forKey: propertyName) as? T)
        }
    }
}
