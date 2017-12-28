//
//  MemberVM.swift
//  Blog
//
//  Created by Q8coders on 12/28/17.
//  Copyright © 2017 Q8coders. All rights reserved.
//

import UIKit

class MemberVM {
    internal func login(member: Member, view: UIView, completion: @escaping(_: [String:Any]) -> Void) {
        let parameters = [
            "email": member.email,
            "password": member.password
        ]
        
        Network.makeRequest(view: view, url: "/api/v1/login/", method: .post, parameters: parameters) { (response) in
            if response["statusCode"] as! Int == 200 {
                Member.storeUserDetail(dict: response)
            }
            completion(response)
        }
    }

}
