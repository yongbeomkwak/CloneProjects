//
//  MenuViewController.swift
//  Tumblr
//
//  Created by yongbeomkwak on 2/10/24.
//

import UIKit

class MenuViewController: UIViewController {

    let transitionManager = TransitionManager()
    
    var textPostIcon: UIImageView = {
        
        let view = UIImageView()
        
        view.image = UIImage(named: "Text")!
        
        return view
    }()
    var textPostLabel: UILabel = {
        
        let view = UILabel()
        
        view.text = "Text"
        
        return view
    }()
    
    var photoPostIcon: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(named: "Photo")!
        
        return view
    }()
    
     var photoPostLabel: UILabel  = {
         
         let view = UILabel()
         
         view.text = "Photo"
         
         return view
     }()
    
     var quotePostIcon: UIImageView = {
         let view = UIImageView()
         
         view.image = UIImage(named: "Quote")!
         
         return view
     }()
    
     var quotePostLabel: UILabel = {
         
         let view = UILabel()
         
         view.text = "Quote"
         
         return view
     }()
    
     var linkPostIcon: UIImageView  = {
         let view = UIImageView()
         
         view.image = UIImage(named: "Link")!
         
         return view
     }()
    
     var linkPostLabel: UILabel = {
         
         let view = UILabel()
         
         view.text = "Link"
         
         return view
     }()
    
     var chatPostIcon: UIImageView = {
         let view = UIImageView()
         
         view.image = UIImage(named: "Chat")!
         
         return view
     }()
    
     var chatPostLabel: UILabel = {
         
         let view = UILabel()
         
         view.text = "Chat"
         
         return view
     }()
    
     var audioPostIcon: UIImageView = {
         let view = UIImageView()
         
         view.image = UIImage(named: "Audio")!
         
         return view
     }()
    
     var audioPostLabel: UILabel = {
         
         let view = UILabel()
         
         view.text = "Audio"
         
         return view
     }()
    
    var button: UIButton = {
        
        let view = UIButton()
        
        view.setTitle("Cancel", for: .normal)
        view.setTitleColor(.white, for: .normal)
        
        return view
        
    }()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.view.backgroundColor = .blue
        self.view.addSubviews(textPostIcon,textPostLabel,photoPostIcon,photoPostLabel,quotePostIcon,quotePostLabel,linkPostIcon,linkPostLabel,chatPostIcon,chatPostLabel,audioPostIcon,audioPostLabel,button)
        
        
        self.button.addTarget(self, action: #selector(tapCancel), for: .touchUpInside)
        
        
        textPostIcon.setTop(anchor: self.view.safeAreaLayoutGuide.topAnchor, constant: 76)
        
        textPostIcon.setLeading(anchor: self.view.leadingAnchor, constant: 53)
        
        textPostLabel.setCenterX(view: self.textPostIcon)
        textPostLabel.setBottom(anchor: self.quotePostIcon.topAnchor, constant: -19)

        
        photoPostIcon.setTop(anchor: self.textPostIcon.topAnchor, constant: .zero)
        photoPostIcon.setTrailing(anchor: self.view.trailingAnchor, constant: -53)
        
        photoPostLabel.translatesAutoresizingMaskIntoConstraints = false
        photoPostLabel.lastBaselineAnchor.constraint(equalTo: textPostLabel.lastBaselineAnchor).isActive = true
        photoPostLabel.setCenterX(view: self.photoPostIcon)
        
        
        quotePostIcon.setLeading(anchor: self.textPostIcon.leadingAnchor, constant: .zero)
        
        quotePostIcon.setTop(anchor: self.textPostIcon.bottomAnchor, constant: 34)
        
        quotePostLabel.setCenterX(view: self.quotePostIcon)
        quotePostLabel.setTop(anchor: self.quotePostIcon.bottomAnchor, constant: 2)
        quotePostLabel.setBottom(anchor: self.chatPostIcon.topAnchor, constant: -13)
        
        linkPostIcon.setLeading(anchor: self.photoPostIcon.leadingAnchor, constant: .zero)
        linkPostIcon.setTop(anchor: self.quotePostIcon.topAnchor, constant: .zero)
        
        linkPostLabel.setCenterX(view: self.linkPostIcon)
        linkPostLabel.translatesAutoresizingMaskIntoConstraints = false
        linkPostLabel.lastBaselineAnchor.constraint(equalTo: quotePostLabel.lastBaselineAnchor).isActive = true
        
        chatPostIcon.setLeading(anchor: quotePostIcon.leadingAnchor, constant: .zero)
        chatPostLabel.setCenterX(view: self.chatPostIcon)
        chatPostLabel.setTop(anchor: self.chatPostIcon.bottomAnchor, constant: 7)
        
        audioPostIcon.setLeading(anchor: linkPostIcon.leadingAnchor, constant: .zero)
        
        audioPostIcon.setTop(anchor: chatPostIcon.topAnchor, constant: .zero)
        
        audioPostLabel.setCenterX(view: audioPostIcon)
        audioPostLabel.translatesAutoresizingMaskIntoConstraints = false
        audioPostLabel.lastBaselineAnchor.constraint(equalTo: chatPostLabel.lastBaselineAnchor).isActive = true
        
        
        button.setCenterX(view: self.view)
        button.setBottom(anchor: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        
        self.transitioningDelegate = self.transitionManager
        
        
    }
    


    @objc func tapCancel() {
        self.dismiss(animated: true)
    }
}
