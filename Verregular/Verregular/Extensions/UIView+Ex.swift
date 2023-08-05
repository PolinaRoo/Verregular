//
//  UIView+Ex.swift
//  Verregular
//
//  Created by Polina Tereshchenko on 01.08.2023.
//

import UIKit

extension UIView {
    func addSubViews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
