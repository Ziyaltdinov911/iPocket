//
//  CameraViewPresenter.swift
//  iPocket
//
//  Created by KAMA . on 20.05.2025.
//

import UIKit


protocol CameraViewPresenterProtocol: AnyObject {
    init(view: CameraViewProtocol, cameraService: CameraServiceProtocol)
    
    var cameraService: CameraServiceProtocol { get set }
    var photos: [UIImage] { get set }
    
    var closeViewAction: UIAction? { get set }
    var switchCameraAction: UIAction? { get set }
}

class CameraViewPresenter: CameraViewPresenterProtocol {
    
    var cameraService: any CameraServiceProtocol
    private weak var view: CameraViewProtocol?
    
    required init(view: CameraViewProtocol, cameraService: CameraServiceProtocol) {
        self.view = view
        self.cameraService = cameraService

    }
    
    var photos: [UIImage] = []
    
    lazy var closeViewAction: UIAction? = UIAction { [weak self] _ in
        NotificationCenter.default.post(name: .goToMain, object: nil)
        self?.cameraService.stopSession()
        
    }
    
    lazy var switchCameraAction: UIAction? = UIAction { [weak self] _ in
        self?.cameraService.switchCamera()
    }
    
    
}
