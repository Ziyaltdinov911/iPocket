//
//  UITextField.ext.swift
//  iPocket
//
//  Created by KAMA . on 18.05.2025.
//

import UIKit

extension UITextField {
    func setLeftOffset() {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 10))
        self.leftViewMode = .always
    }
}
