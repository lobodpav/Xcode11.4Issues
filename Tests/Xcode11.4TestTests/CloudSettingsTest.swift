import Combine
import XCTest
@testable import Xcode11_4Test

final class CloudSettingsTest: XCTestCase {
    func testIncomingCloudChange() {
        let expectation = XCTestExpectation(description: "Change published")

        CloudListener.syncEnabled = true

        let cloudSetting = CloudSetting<String>("cloudProperty") { value in
            XCTAssertEqual(value, "TestValue")
            expectation.fulfill()
        }

        NSUbiquitousKeyValueStore.default.set("TestValue", forKey: cloudSetting.propertyName)

        print("**** TEST: Will publish key change via notification center")

        // post a notification
        let userInfo: [AnyHashable: Any] = [
            "NSUbiquitousKeyValueStoreChangeReasonKey": NSUbiquitousKeyValueStoreServerChange,
            "NSUbiquitousKeyValueStoreChangedKeysKey": [cloudSetting.propertyName]
        ]

        NotificationCenter.default.post(name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
                                        object: self, userInfo: userInfo)

        wait(for: [expectation], timeout: 0.5)
    }
}
