//
//  Member.swift
//  Blog
//
//  Created by Q8coders on 12/28/17.
//  Copyright © 2017 Q8coders. All rights reserved.
//

import UIKit
import SwiftyJSON

class Member {
    var id:CLong = 0
    var email = ""
    var phone = ""
    var password = ""
    
    static func isLoggedIn() -> Bool {
        guard let _ = UserDefaults.standard.object(forKey: Constants.REG_MEMBER_ID) else {
            return false
        }
        return true
    }
    
    static func loggedInUser() -> Member {
        let member = Member()
        
        if isLoggedIn() {
            let userDefaults = UserDefaults.standard
            member.id = userDefaults.object(forKey: Constants.REG_MEMBER_ID) as! CLong
            member.email = userDefaults.object(forKey: Constants.REG_MEMBER_EMAIL) as! String
            member.phone = userDefaults.object(forKey: Constants.REG_MEMBER_PHONE) as! String
        }
        
        return member
    }
    
    static func parser(dict: [String: Any]) -> Member {
        let member = Member()
        
        member.id = dict["id"] as! CLong
        member.email = dict["email"] as! String
        member.phone = dict["phone"] as! String
        
        return member
    }
    
    static func storeUserDetail(dict: [String:Any]) {
        let defaults = UserDefaults.standard
        defaults.setValue(dict["id"], forKey: Constants.REG_MEMBER_ID)
        defaults.setValue(dict["email"], forKey: Constants.REG_MEMBER_EMAIL)
        defaults.setValue(dict["phone"], forKey: Constants.REG_MEMBER_PHONE)
        defaults.synchronize()
    }
    
    static func logout() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Constants.REG_MEMBER_ID)
        defaults.removeObject(forKey: Constants.REG_MEMBER_EMAIL)
        defaults.removeObject(forKey: Constants.REG_MEMBER_PHONE)
        defaults.synchronize()
    }
    
    internal func validateLogin() -> String? {
        var errors = [String]()
    
        if email.isEmpty || !email.isValidEmail() {
            errors.append(NSLocalizedString("Invalid email address", comment: ""))
        }
        
        if password.isEmpty {
            errors.append(NSLocalizedString("Password is required", comment: ""))
        }
        
        return Helpers.singleString(stringArray: errors)
    }
}
