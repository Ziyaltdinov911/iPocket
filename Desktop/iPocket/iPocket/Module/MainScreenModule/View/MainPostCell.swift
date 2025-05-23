//
//  MainPostCellCollectionViewCell.swift
//  iPocket
//
//  Created by KAMA . on 03.05.2025.
//

import UIKit

class MainPostCell: UICollectionViewCell, CollectionViewCellProtocol {
    
    static let reuseId = "MainPostCell"
    private lazy var tags: [String] = []
    
    private var tagCollectionView: UICollectionView!
    
    private var photoCountLabel = UILabel()
    
    private var commentCountLabel = UILabel()
    
    private var postDescriptionLabel = UILabel()
    
    private lazy var postImage: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        
        return $0
    }(UIImageView(frame: bounds))
    
    private lazy var countLabelsStack: UIStackView = {
        .configure(view: $0) { [weak self] stack in
            guard let self = self else { return }
            stack.axis = .horizontal
            stack.spacing = 20
            stack.addArrangedSubview(self.photoCountLabel)
            stack.addArrangedSubview(self.commentCountLabel)
            stack.addArrangedSubview(UIView())
            
        }
    }(UIStackView())
    
    private lazy var addFavoriteButton: UIButton = {
        $0.frame = CGRect(x: bounds.width - 60, y: 35, width: 25, height: 25)
        $0.setBackgroundImage(.heart, for: .normal)
        $0.tintColor = .black
        return $0
    }(UIButton(primaryAction: nil))
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        contentViewConfig()
    }
    
    private func contentViewConfig() {
        
        [postImage, addFavoriteButton].forEach {
            addSubview($0)
        }

        layer.cornerRadius = 30
        clipsToBounds = true
        
        setViewGradient(frame: bounds, startPoint: CGPoint(x: 0.5, y: 1), endPoint: CGPoint(x: 0.5, y: 0.5), colors: [.black, .clear], location: [0,1])
    }
    
    override func prepareForReuse() {
        tagCollectionView.removeFromSuperview()
        postDescriptionLabel.removeFromSuperview()
    }
    
    func configureCell(item: PostItem) {
        tags = item.tags ?? []
        
        let tagCollection: TagCollectionViewProtocol = TagCollectionView(dataSource: self)
        tagCollectionView = tagCollection.getCollectionView()
        
        postImage.image = UIImage(named: item.photos.first!)
        
        photoCountLabel = getCellLabel(text: "\(item.photos.count) фото")
        commentCountLabel = getCellLabel(text: "\(item.comments?.count ?? 0) комментарий")
        postDescriptionLabel = getCellLabel(text: "\(item.description ?? "")")
        
        [countLabelsStack, tagCollectionView, postDescriptionLabel].forEach {
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            
            countLabelsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            countLabelsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            countLabelsStack.bottomAnchor.constraint(equalTo: tagCollectionView.topAnchor, constant: -8),
            
            tagCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tagCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tagCollectionView.heightAnchor.constraint(equalToConstant: 40),
            tagCollectionView.bottomAnchor.constraint(equalTo: postDescriptionLabel.topAnchor, constant: -10),
            
            postDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            postDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            postDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
        ])
    }
    
    
    private func getCellLabel(text: String) -> UILabel {
        return {
            .configure(view: $0) {
                $0.numberOfLines = 0
                $0.font = UIFont.systemFont(ofSize: 14)
                $0.text = text
                $0.textColor = .white
            }
        }(UILabel())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MainPostCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionCell.reuseId, for: indexPath) as! TagCollectionCell
        
        let tag = tags[indexPath.item]
        cell.cellConfigure(tagText: tag)
        
        return cell
    }
    
    
}
