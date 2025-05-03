//
//  Builder.swift
//  iPocket
//
//  Created by KAMA . on 27.04.2025.
//

import Foundation
import UIKit

protocol BuilderProtocol {
    static func getPasscodeController(passcodeState: PasscodeState) -> UIViewController
    
}

class Builder: BuilderProtocol {
    static func getPasscodeController(passcodeState: PasscodeState) -> UIViewController {
        let passcodeView = PasscodeView()
        let keychainManager = KeychainManager()
        let presenter = PasscodePresenter(view: passcodeView, passcodeState: passcodeState, keychainManager: keychainManager)
        
        passcodeView.passcodePresenter = presenter
        return passcodeView
    }
}
