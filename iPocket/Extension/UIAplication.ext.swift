//
//  UIAplication.ext.swift
//  iPocket
//
//  Created by KAMA . on 06.05.2025.
//

import UIKit

extension UIApplication {
    static var topSafeArea: CGFloat {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return scene?.windows.first?.safeAreaInsets.top ?? .zero
    }
}

