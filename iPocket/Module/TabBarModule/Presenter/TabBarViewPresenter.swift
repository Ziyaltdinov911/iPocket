//
//  TabBarViewPresenter.swift
//  iPocket
//
//  Created by KAMA . on 03.05.2025.
//

import UIKit

protocol TabBarViewPresenterProtocol: AnyObject {
    init(view: TabBarViewProtocol)
    func buildTabBar()
}

class TabBarViewPresenter {
//    var tabs: [UIImage] = [.home, .plusBtn, .heart]

    weak var view: (TabBarViewProtocol)?
    
    required init(view: any TabBarViewProtocol) {
        self.view = view
        self.buildTabBar()
        
    }
    
}

extension TabBarViewPresenter: TabBarViewPresenterProtocol {

    func buildTabBar() {
        let mainScreen = Builder.createMainScreenController()
        let cameraScreen = Builder.createCameraScreenController()
        let favoriteScreen = Builder.createFavoriteScreenController()
        
        self.view?.setControllers(controllers: [mainScreen, cameraScreen, favoriteScreen])
    }
}
