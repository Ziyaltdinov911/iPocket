//
//  FavoriteViewPresenter.swift
//  iPocket
//
//  Created by KAMA . on 10.05.2025.
//

import UIKit

protocol FavoriteViewPresenterProtocol: AnyObject {
    init(view: FavoriteViewProtocol)
    var post: [PostItem]? { get set }
    
    func getPosts()
}

class FavoriteViewPresenter: FavoriteViewPresenterProtocol {
    
    var post: [PostItem]?
    
    private weak var view: FavoriteViewProtocol?
    
    required init(view: any FavoriteViewProtocol) {
        self.view = view
        
        getPosts()
        
    }
    
    func getPosts() {
        self.post = PostItem.getMockItem()
        self.view?.showPosts()
    }
    
}
