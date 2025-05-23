//
//  DetailsAddCommentCell.swift
//  iPocket
//
//  Created by KAMA . on 18.05.2025.
//

import UIKit

class DetailsAddCommentCell: UICollectionViewCell, CollectionViewCellProtocol {
    static var reuseId: String = "DetailsAddCommentCell"
    
    var completion: ((String) -> ())?
    
    lazy var action = UIAction { [weak self] sender in
        let textField = sender.sender as! UITextField
        self?.completion?(textField.text ?? "")
        self?.endEditing(true)
    }
    
    private lazy var textField: UITextField = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = bounds.height / 2
        $0.placeholder = "Добавить комментарий"
        $0.setLeftOffset()
        
        return $0
    }(UITextField(frame: bounds, primaryAction: action))
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
