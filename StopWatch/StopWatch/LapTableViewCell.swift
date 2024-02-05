//
//  LapTableViewCell.swift
//  StopWatch
//
//  Created by yongbeomkwak on 2/5/24.
//

import UIKit

class LapTableViewCell: UITableViewCell {

    static let id = "LapTableViewCell"
    
    var titleLabel: UILabel = {
       
        let view = UILabel()
        
        
        return view
        
    }()
    
    var timeLabel: UILabel = {
        
        let view = UILabel()
        
        
        return view
    }()

     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubviews(titleLabel,timeLabel)
        
        
        titleLabel.setLeading(anchor: self.contentView.leadingAnchor, constant: 20)
        timeLabel.setTrailing(anchor: self.contentView.trailingAnchor, constant: -20)
        
        titleLabel.setCenterY(view: self.contentView)
        timeLabel.setCenterY(view: self.contentView)
         
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
     }


}

extension LapTableViewCell {
    
    func update(_ title:String , _ time:String) {
        titleLabel.text = title
        timeLabel.text = time
    }
    
}
