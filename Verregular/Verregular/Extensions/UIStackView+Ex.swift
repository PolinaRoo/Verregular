//
//  UIStackView+Ex.swift
//  Verregular
//
//  Created by Polina Tereshchenko on 01.08.2023.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
