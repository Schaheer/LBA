//
//  UIScrollView.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 07/04/2022.
//

import UIKit

extension UIScrollView {

    func resizeScrollViewContentSize() {

        var contentRect = CGRect.zero

        for view in self.subviews {
            contentRect = contentRect.union(view.frame)
        }

        self.contentSize = contentRect.size
    }
}
