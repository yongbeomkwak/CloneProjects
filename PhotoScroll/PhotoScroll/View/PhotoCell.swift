//
//  PhotoCell.swift
//  PhotoScroll
//
//  Created by yongbeomkwak on 2/7/24.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    static let id : String = "PhotoCell"
    
    var imageView : UIImageView = {
        
        let view = UIImageView()
        
    
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

extension PhotoCell {
    
    func update(_ image: UIImage) {
        self.imageView.image = image
    }
}


