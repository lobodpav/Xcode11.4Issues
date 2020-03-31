import Foundation

/// Registers an observer for `NSUbiquitousKeyValueStore`, and calls a handler once a change is detected
class CloudListener {
    private var observer: NSObjectProtocol?
    private var changeHandler: ((_ changedKeys: [String]) -> (Void))?

    @UserDefaultsWrapper("cloudSyncEnabled")
    static var syncEnabled = false

    func listenForChanges(_ changeHandler: @escaping (_ changedKeys: [String]) -> (Void)) {
        self.changeHandler = changeHandler

        print("!!!! Adding Cloud observer")
        observer = NotificationCenter.default.addObserver(forName: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
                                                          object: nil, queue: nil, using: cloudChangeObserver)
    }

    private func cloudChangeObserver(notification: Notification) {
        print("!!!! Cloud change observed")

        let changedKeys = notification.userInfo?["NSUbiquitousKeyValueStoreChangedKeysKey"] as? [String] ?? []

        if Self.syncEnabled {
            print("!!!! Reporting changed cloud key")
            changeHandler?(changedKeys)
        }
    }
}
