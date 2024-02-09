//
//  InterestCollectionViewCell.swift
//  Interest
//
//  Created by yongbeomkwak on 2/9/24.
//

import UIKit

class InterestCollectionViewCell: UICollectionViewCell {
    
    static let id : String = "InterestCollectionViewCell"
    
    var imageView: UIImageView = {
        
        let view = UIImageView()
        
        return view
    } ()
    
    var titleLabel: UILabel = {
        
        let view = UILabel()
        
        return view
    }()
    
    var visualEffectView : UIVisualEffectView = {
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        let view = UIVisualEffectView(effect: blurEffect)
        
        return view
    }()
    
    var containerView: UIView = UIView()
    
    var interest: Interest! {
        didSet {
            prepare()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubviews(imageView,visualEffectView)
        
        imageView.fillSuperview()
        visualEffectView.setHeight(80)
        visualEffectView.setBottom(anchor: contentView.bottomAnchor, constant: .zero)
        visualEffectView.setHorizon(constant: .zero)
        
        visualEffectView.contentView.addSubviews(containerView)
        
        containerView.fillSuperview()
        
        containerView.addSubview(titleLabel)
        
        titleLabel.setHorizon(constant: 8)
        titleLabel.setTop(anchor: containerView.topAnchor, constant: 8)
        titleLabel.setBottom(anchor: containerView.bottomAnchor, constant: 16)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func prepare() {
        imageView.image = interest.featuredImage
        titleLabel.text = interest.title
    }
    
}
