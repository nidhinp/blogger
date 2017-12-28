//
//  UITableView+Extensions.swift
//  store
//
//  Created by Q8coders on 12/11/17.
//  Copyright © 2017 Q8coders. All rights reserved.
//

import UIKit

extension UITableView {
    func indexPath(for view: UIView) -> IndexPath? {
        let location = view.convert(CGPoint.zero, to: self)
        return self.indexPathForRow(at: location)
    }
}
