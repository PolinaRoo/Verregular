//
//  String + Ex.swift
//  Verregular
//
//  Created by Polina Tereshchenko on 31.07.2023.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
