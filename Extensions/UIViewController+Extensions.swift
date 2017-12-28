//
//  UIViewController+Extensions.swift
//  store
//
//  Created by Q8coders on 12/12/17.
//  Copyright © 2017 Q8coders. All rights reserved.
//

import UIKit

extension UIViewController {
    func removeBackButtonText() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
