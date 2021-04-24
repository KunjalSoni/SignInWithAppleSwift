//
//  ViewController.swift
//  SignInWithAppleSwift
//
//  Created by Kunjal Soni on 04/17/2021.
//  Copyright (c) 2021 Kunjal Soni. All rights reserved.
//

import UIKit
import SignInWithAppleSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startAppleSignIn() {
        SignInWithApple.shared.requestAuthorization(scope: [.email, .fullName], presentationContextProvider: self) { (result) in
            let alert = UIAlertController(title: "Error", message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Okay", style: .default) { (_) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(alertAction)
            if result.error != nil {
                alert.message = result.error
                self.present(alert, animated: true, completion: nil)
                return
            }
            alert.title = result.userDetails?.emailId
            alert.message = (result.userDetails?.firstName ?? "") + " " + (result.userDetails?.lastName ?? "")
            self.present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func btnSignInTapped(_ sender: Any) {
        startAppleSignIn()
    }
    
}

