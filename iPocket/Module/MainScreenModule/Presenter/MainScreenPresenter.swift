//
//  MainScreenPresenter.swift
//  iPocket
//
//  Created by KAMA . on 03.05.2025.
//

import UIKit

protocol MainScreenPresenterProtocol: AnyObject {
    init(view: MainScreenViewProtocol)
    var posts: [PostDate]? { get set }
    
    func getPosts()
}

class MainScreenPresenter {
    weak var view: MainScreenViewProtocol?
    var posts: [PostDate]?
    
    
    required init(view: any MainScreenViewProtocol) {
        self.view = view
        getPosts()
    }
}

extension MainScreenPresenter: MainScreenPresenterProtocol {
    func getPosts() {
        self.posts = PostDate.getMockData()
        
        view?.showPosts()
    }
}
