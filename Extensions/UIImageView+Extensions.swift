//
//  UIImageView+Extensions.swift
//  GetraConsumer
//
//  Created by Q8coders on 11/18/17.
//  Copyright © 2017 Q8coders. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    func setImage(imageUrl: String) {
        if imageUrl.count > 0 {
            self.kf.indicatorType = .activity
            self.kf.setImage(with: URL(string: imageUrl), options: [.transition(.fade(0.2))])
        }else {
            self.image = #imageLiteral(resourceName: "images")
        }
    }
}
