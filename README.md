# SignInWithAppleSwift

[![Version](https://img.shields.io/cocoapods/v/SignInWithAppleSwift.svg?style=flat)](https://cocoapods.org/pods/SignInWithAppleSwift)
[![License](https://img.shields.io/cocoapods/l/SignInWithAppleSwift.svg?style=flat)](https://cocoapods.org/pods/SignInWithAppleSwift)
[![Platform](https://img.shields.io/cocoapods/p/SignInWithAppleSwift.svg?style=flat)](https://cocoapods.org/pods/SignInWithAppleSwift)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Features
  - Only one line of code to retrive user details
  - Remembers previously authenticated user details using  'SwiftKeychainWrapper'
  - No more minimum iOS 13 availablility conditions. Let us handle that for you!

## Requirements
  - iOS 11.0+
  - Xcode 11+

## Installation
 **CocoaPods**
 
- You can use CocoaPods to install SignInWithAppleSwift by adding it to your Podfile:

        use_frameworks!
        pod 'SignInWithAppleSwift'

- In the swift file, import SSSideMenu module:
            
        import UIKit
        import SignInWithAppleSwift


## Usage

**Setup your app for Sign in with Apple capability:**
1. Open your Xcode Project.
2. Project Navigator→ Select Project → Select Target.
3. In Project Editor, Click Signing & Capabilities.
4. Add Capability by clicking the + button. Search for Sign In with Apple Capability in Capability Library.
5. Double-click the capability to add.

**Retrieve user details:**
            
        SignInWithApple.shared.requestAuthorization(scope: [.email, .fullName], presentationsContextProvider: self) { (result) 
            print("error: ", result.error)
            print("user details: ", result.userDetails)
        }

## Author

Kunjal Soni, sonikunj141297@gmail.com

## License

SignInWithAppleSwift is available under the MIT license. See the LICENSE file for more info.
