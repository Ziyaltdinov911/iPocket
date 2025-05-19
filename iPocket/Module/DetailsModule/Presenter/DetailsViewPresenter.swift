//
//  DetailsViewPresenter.swift
//  iPocket
//
//  Created by KAMA . on 14.05.2025.
//

import UIKit

protocol DetailsViewPresenterProtocol: AnyObject {
    init(view: DetailsViewProtocol, item: PostItem)
    var item: PostItem { get }
}

class DetailsViewPresenter: DetailsViewPresenterProtocol {
    
    private weak var view: DetailsViewProtocol?
    
    var item: PostItem

    required init(view: any DetailsViewProtocol, item: PostItem) {
        self.item = item
        self.view = view
    }
        
    
}
