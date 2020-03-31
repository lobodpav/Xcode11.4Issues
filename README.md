# Xcode 11.4 Test

`Xcode 11.4` has broken the test. It was working in the previous version.

The test will succeed if either of these steps is done:
1. Comment out `@UserDefaultsWrapper("cloudSyncEnabled")` in `CloudListener`
2. Remove `static` keyword from the `syncEnabled` variable in `CloudListener`
3. Remove `projectedValue` variable from the `UserDefaultsWrapper` 
