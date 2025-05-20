//
//  CameraViewPresenter.swift
//  iPocket
//
//  Created by KAMA . on 20.05.2025.
//

import UIKit


protocol CameraViewPresenterProtocol: AnyObject {
    init(view: CameraViewProtocol)
    
    var photos: [UIImage] { get set }
    
    var closeViewAction: UIAction? { get set }
    var switchCameraAction: UIAction? { get set }
}

class CameraViewPresenter: CameraViewPresenterProtocol {
    private weak var view: CameraViewProtocol?
    
    required init(view: CameraViewProtocol) {
        self.view = view

    }
    
    var photos: [UIImage] = []
    
    var closeViewAction: UIAction? = UIAction { _ in
        NotificationCenter.default.post(name: .goToMain, object: nil)
    }
    
    var switchCameraAction: UIAction? = UIAction { _ in
        
    }
    
    
}
