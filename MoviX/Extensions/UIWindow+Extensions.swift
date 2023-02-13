//
//  UIWindow+Extensions.swift
//  MoviX
//
//  Created by Muhammad Ewaily on 13/02/2023.
//

import UIKit

extension UIWindow {
    static var isLandscape: Bool {
        return UIApplication.shared.windows
            .first?
            .windowScene?
            .interfaceOrientation
            .isLandscape ?? false
    }
}
