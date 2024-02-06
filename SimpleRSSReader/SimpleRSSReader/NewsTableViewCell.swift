//
//  NewsTableViewCell.swift
//  SimpleRSSReader
//
//  Created by yongbeomkwak on 2/6/24.
//

import UIKit

enum CellState {
  case expanded
  case collapsed
}

class NewsTableViewCell: UITableViewCell {
    
    static let  id: String = "NewsTableViewCell"

    var titleLabel: UILabel = {
        
        let view = UILabel()
        
        view.font = .boldSystemFont(ofSize: 15)
        
        return view
    }()
    
    var descriptionLabel: UILabel = {
        
        let view = UILabel()
        
        view.numberOfLines = 4
        view.font = .boldSystemFont(ofSize: 10)
        
        return view
        
    }()
    
    var dateLabel : UILabel = {
        
        let view = UILabel()
        
        view.font = .boldSystemFont(ofSize: 8)
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubviews(titleLabel,descriptionLabel,dateLabel)
        
        
        titleLabel.setLeading(anchor: self.contentView.leadingAnchor, constant: 20)
        titleLabel.setTop(anchor: self.contentView.topAnchor, constant: 20)
        titleLabel.setTrailing(anchor: self.contentView.trailingAnchor, constant: -20)
        
        descriptionLabel.setLeading(anchor: self.contentView.leadingAnchor, constant: 20)
        descriptionLabel.setTop(anchor: self.titleLabel.bottomAnchor, constant: 20)
        descriptionLabel.setTrailing(anchor: self.contentView.trailingAnchor, constant: -20)

        
        dateLabel.setLeading(anchor: self.contentView.leadingAnchor, constant: 20)
        dateLabel.setTop(anchor: self.descriptionLabel.bottomAnchor, constant: 10)
        dateLabel.setTrailing(anchor: self.contentView.trailingAnchor, constant: -20)
        dateLabel.setBottom(anchor: self.contentView.bottomAnchor, constant: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
