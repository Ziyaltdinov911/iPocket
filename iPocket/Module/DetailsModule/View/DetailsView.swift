//
//  DetailsView.swift
//  iPocket
//
//  Created by KAMA . on 14.05.2025.
//

import UIKit

protocol DetailsViewProtocol: AnyObject {
    
}

class DetailsView: UIViewController {
    
    var presenter: DetailsViewPresenterProtocol!
    
    private lazy var menuViewHeight = UIApplication.topSafeArea + 50
    
    private lazy var topMenuView: UIView = {
        $0.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: menuViewHeight)
        $0.backgroundColor = .appMain
        
        return $0
    }(UIView())
    
    
    lazy var backAction = UIAction { [weak self] _ in
        self?.navigationController?.popViewController(animated: true)
    } 
    
    lazy var menuAction = UIAction { [weak self] _ in
        print("menu open")
    }
    
    
    lazy var navigationHeader: NavigationHeader = {
        NavigationHeader(backAction: backAction, menuAction: menuAction, date: presenter.item.date)
    }()
    
    private func setupPageHeader() {
        let headerView = navigationHeader.getNavigationHeader(type: .back)
        headerView.frame.origin.y = UIApplication.topSafeArea
        view.addSubview(headerView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appMain
        view.addSubview(topMenuView)
        setupPageHeader()

    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.isHidden = true
    }
}

extension DetailsView: DetailsViewProtocol {
    
}
