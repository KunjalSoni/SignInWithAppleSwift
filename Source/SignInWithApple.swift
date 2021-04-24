//
//  SignInWithApple.swift
//  Pods-SignInWithAppleSwift_Example
//
//  Created by Kunjal Soni on 17/04/21.
//

import UIKit
import AuthenticationServices

public typealias Listener = ((AppleIdCredentials?, String?)) -> ()

public struct AppleIdCredentials {
    let firstName: String?
    let lastName: String?
    let userId: String?
    let emailId: String?
    
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
    
    open func requestAuthorization(scope: SignInWithApple, presentationContextProvider: UIViewController, response: @escaping Listener) {
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
            self.listener?((nil, "Sign in with Apple is not supported in your current version of iOS"))
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
            
            let appleIdCredentials = AppleIdCredentials(fName: fullName?.givenName, lName: fullName?.familyName, userId: userIdentifier, emailId: email)
            self.listener?((appleIdCredentials, "Sign in with Apple is not supported in your current version of iOS"))
        } else {
            self.listener?((nil, "Error occurred. Please try again later"))
        }
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.listener?((nil, "Error occurred. Please try again later"))
    }
}
