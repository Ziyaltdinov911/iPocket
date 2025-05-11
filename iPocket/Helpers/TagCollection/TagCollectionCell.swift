//
//  TagCollectionCell.swift
//  iPocket
//
//  Created by KAMA . on 08.05.2025.
//

import UIKit

class TagCollectionCell: UICollectionViewCell {
    static let reuseId = "TagCollectionCell"
    
    private lazy var tagView: UIView = {
        .configure(view: $0) { [weak self] tagView in
            
            guard let self = self else { return }
            tagView.backgroundColor = UIColor(white: 1, alpha: 0.2)
            tagView.layer.cornerRadius = 15
            tagView.addSubview(self.tagLabel)
        }
    }(UIView())
    
    private lazy var tagLabel: UILabel = {
        .configure(view: $0) {
            $0.textColor = .white
            $0.font = UIFont.systemFont(ofSize: 14)
        }
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tagView)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tagView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tagView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tagView.topAnchor.constraint(equalTo: topAnchor),
            tagView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            tagLabel.topAnchor.constraint(equalTo: tagView.topAnchor, constant: 5),
            tagLabel.bottomAnchor.constraint(equalTo: tagView.bottomAnchor, constant: -5),
            tagLabel.leadingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: 20),
            tagLabel.trailingAnchor.constraint(equalTo: tagView.trailingAnchor, constant: -20),
        ])
    }
    
    func cellConfigure(tagText: String) {
        self.tagLabel.text = tagText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
