//
//  UIView.ext.swift
//  iPocket
//
//  Created by KAMA . on 27.04.2025.
//

import UIKit

extension UIView {
    static func configure<T: UIView>(view: T, block: @escaping (T) -> ()) -> T {
        view.translatesAutoresizingMaskIntoConstraints = false
        block(view)
        return view
    }
}
