//
//  SignInWithApple.swift
//  Pods-SignInWithAppleSwift_Example
//
//  Created by Kunjal Soni on 17/04/21.
//

import UIKit
import AuthenticationServices
import SwiftKeychainWrapper

public typealias Listener = (AppleSignInResult) -> ()

public struct AppleSignInResult {
    public let userDetails: AppleUserDetails?
    public let error: String?
}

public struct AppleUserDetails {
    public let firstName: String?
    public let lastName: String?
    public let userId: String?
    public let emailId: String?
    
    init(fName: String?, lName: String?, userId: String?, emailId: String?) {
        self.firstName = fName
        self.lastName = lName
        self.userId = userId
        self.emailId = emailId
    }
}

public enum SignInWithAppleScope {
    case fullName
    case email
}

open class SignInWithApple: NSObject {
    
    public static let shared = SignInWithApple()
    
    private var listener: Listener?
    private var presentationContextProvider: UIViewController?
    
    open func requestAuthorization(scope: [SignInWithAppleScope], presentationContextProvider: UIViewController, response: @escaping Listener) {
        self.listener = response
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            self.presentationContextProvider = presentationContextProvider
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        } else {
            self.listener?(AppleSignInResult(userDetails: nil, error: "Sign in with Apple is not supported in your current version of iOS"))
        }
    }
    
}

extension SignInWithApple: ASAuthorizationControllerPresentationContextProviding {
    
    @available(iOS 13.0, *)
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.presentationContextProvider!.view.window!
    }
}

@available(iOS 13.0, *)
extension SignInWithApple: ASAuthorizationControllerDelegate {
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            if let firstName = appleIDCredential.fullName?.familyName, let lastName = appleIDCredential.fullName?.givenName, let emailId = appleIDCredential.email {
                KeychainWrapper.standard.set(lastName, forKey: userIdentifier + "familyNameForAppleSignIn")
                KeychainWrapper.standard.set(firstName, forKey: userIdentifier + "givenNameForAppleSignIn")
                KeychainWrapper.standard.set(emailId, forKey: userIdentifier + "appleEmailId")
            }
            
            let keychainFamilyName = KeychainWrapper.standard.string(forKey: userIdentifier + "familyNameForAppleSignIn")
            let keychainGivenName = KeychainWrapper.standard.string(forKey: userIdentifier + "givenNameForAppleSignIn")
            let keychainEmail = KeychainWrapper.standard.string(forKey: userIdentifier + "appleEmailId")
            
            let firstName = fullName?.givenName ?? keychainGivenName
            let lastName = fullName?.familyName ?? keychainFamilyName
            let userEmail = email ?? keychainEmail
            
            let appleUser = AppleUserDetails(fName: firstName, lName: lastName, userId: userIdentifier, emailId: userEmail)
            
            self.listener?(AppleSignInResult(userDetails: appleUser, error: nil))
        } else {
            self.listener?(AppleSignInResult(userDetails: nil, error: "Error occurred. Please try again later"))
        }
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.listener?(AppleSignInResult(userDetails: nil, error: error.localizedDescription))
    }
}
