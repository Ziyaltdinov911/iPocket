//
//  PasscodeView.swift
//  iPocket
//
//  Created by KAMA . on 27.04.2025.
//

import UIKit

protocol PasscodeViewProtocol {
    func passcodeState(state: PasscodeState)
    func enterCode(code: [Int])
}

class PasscodeView: UIViewController {
    
    var passcodePresenter: PasscodePresenterProtocol!
    
    private let buttons: [ [Int] ] = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [0]]
    private let codeLength = 4
    
    private lazy var passcodeTitle: UILabel = {
        .configure(view: $0) { label in
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            label.textAlignment = .center
        }
    }(UILabel())
    
    private lazy var keyboardStack: UIStackView = {
        .configure(view: $0) { stack in
            stack.axis = .vertical
            stack.distribution = .equalSpacing
            stack.alignment = .center
        }
    }(UIStackView())

    private lazy var codeStack: UIStackView = {
        .configure(view: $0) { stack in
            stack.axis = .horizontal
            stack.distribution = .equalCentering
            stack.spacing = 20
        }
    }(UIStackView())
    
    private lazy var deleteBtn: UIButton = {
        .configure(view: $0) { btn in
            btn.widthAnchor.constraint(equalToConstant: 36).isActive = true
            btn.heightAnchor.constraint(equalToConstant: 36).isActive = true
            btn.setBackgroundImage(.deleteBtn, for: .normal)
        }
    }(UIButton(primaryAction: deleteCodeAction))
    
    private lazy var enterCodeAction = UIAction { [weak self] sender in
        guard
            let self = self,
            let sender = sender.sender as? UIButton
                
        else { return }
        
        self.passcodePresenter.enterPasscode(number: sender.tag)
    }
    
    private lazy var deleteCodeAction = UIAction { [weak self] sender in
        guard
            let self = self,
            let sender = sender.sender as? UIButton
                
        else { return }
        
        self.passcodePresenter.removeLastItemInPasscode()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appMain
        [keyboardStack, passcodeTitle, codeStack, deleteBtn].forEach {
            view.addSubview($0)
        }
        
        buttons.forEach {
            let buttonLine = setHorizontalNumStack(range: $0)
            keyboardStack.addArrangedSubview(buttonLine)
        }
        
        (0..<codeLength).forEach {_ in 
            let indicator = getCodeIndicatorView()
            codeStack.addArrangedSubview(indicator)
        }
        
        NSLayoutConstraint.activate([
            
            passcodeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passcodeTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passcodeTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            passcodeTitle.heightAnchor.constraint(equalToConstant: 50),
            
            codeStack.topAnchor.constraint(equalTo: passcodeTitle.bottomAnchor, constant: 50),
            codeStack.widthAnchor.constraint(equalToConstant: 140),
            codeStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            keyboardStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            keyboardStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            keyboardStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            keyboardStack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80),
            
            deleteBtn.rightAnchor.constraint(equalTo: keyboardStack.rightAnchor, constant: -20),
            deleteBtn.bottomAnchor.constraint(equalTo: keyboardStack.bottomAnchor, constant: -25),
        ])
    }
    
}

extension PasscodeView {
    private func getHorizontalNumStack() -> UIStackView {
        return {
            .configure(view: $0) { stack in
                stack.axis = .horizontal
                stack.spacing = 50
            }
        }(UIStackView())
    }
    
    private func setHorizontalNumStack(range: [Int]) -> UIStackView {
        let stack = getHorizontalNumStack()
        range.forEach {
            let numButton = UIButton(primaryAction: enterCodeAction)
            numButton.tag = $0
            numButton.setTitle("\($0)", for: .normal)
            numButton.setTitleColor(.white, for: .normal)
            numButton.titleLabel?.font = UIFont.systemFont(ofSize: 60, weight: .light)
            numButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
            stack.addArrangedSubview(numButton)
        }
        
        return stack
    }
    
    private func getCodeIndicatorView() -> UIView {
        let view = UIView()
        view.widthAnchor.constraint(equalToConstant: 20).isActive = true
        view.heightAnchor.constraint(equalToConstant: 20).isActive = true
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.backgroundColor = .clear
        return view
    }
}

extension PasscodeView: PasscodeViewProtocol {
    
    func passcodeState(state: PasscodeState) {
        passcodeTitle.text = state.getPasscodeLabel()
        
    }
    
    func enterCode(code: [Int]) {
        for (index, view) in codeStack.arrangedSubviews.enumerated() {
            view.backgroundColor = index < code.count ? .white : .clear
        }
    }
}
