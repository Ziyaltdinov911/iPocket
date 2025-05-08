//
//  StringProtocol.ext.swift
//  iPocket
//
//  Created by KAMA . on 27.04.2025.
//

import UIKit

extension StringProtocol {
    var digits: [Int] { compactMap(\.wholeNumberValue) }
}
