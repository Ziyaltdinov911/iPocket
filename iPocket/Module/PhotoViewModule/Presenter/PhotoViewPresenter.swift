//
//  PhotoViewPresenter.swift
//  iPocket
//
//  Created by KAMA . on 18.05.2025.
//

import UIKit

protocol PhotoViewPresenterProtocol: AnyObject {
    init(view: PhotoViewProtocol, image: UIImage?)
    var image: UIImage? { get set }
}

class PhotoViewPresenter: PhotoViewPresenterProtocol {
    
    var image: UIImage?
    private weak var view: PhotoViewProtocol?
    
    required init(view: any PhotoViewProtocol, image: UIImage?) {
        self.image = image
        self.view = view
    }
    
}
