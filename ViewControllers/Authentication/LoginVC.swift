//
//  LoginVC.swift
//  Blog
//
//  Created by Q8coders on 12/25/17.
//  Copyright © 2017 Q8coders. All rights reserved.
//

import UIKit
import RNLoadingButton_Swift
import BRYXBanner

class LoginVC: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    let memberVM = MemberVM()
    let member = Member()
    
    // MARK: - View Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        initializer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Actions
    @IBAction func login(_ sender: RNLoadingButton) {
        member.email = emailTextField.text ?? ""
        member.password = passwordTextField.text ?? ""
        guard let errorMessage = member.validateLogin() else {
            Helpers.toggleButton(sender: sender, view: view)
            
            memberVM.login(member: member, view: UIView(), completion: { (result) in
                Helpers.toggleButton(sender: sender, view: self.view)
            })
            
            return
        }
        
        Helpers.showValidationError(error: errorMessage)
    }
    
    
    // MARK: - Private view methods
    fileprivate func initializer() {
    }
}
