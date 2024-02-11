//
//  ViewController.swift
//  Tumblr
//
//  Created by yongbeomkwak on 2/10/24.
//

import UIKit

class ViewController: UIViewController {

    
    //let transitionManager = TransitionManager()
    
    var toolbar : UIToolbar = {
        let view = UIToolbar()
        
        return view
    }()
    
    var button: UIBarButtonItem = {
        let view = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapPlus))
       
        view.tintColor = .red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubviews(toolbar)
        
        toolbar.setHorizon(constant: .zero)
        toolbar.setBottom(anchor: self.view.safeAreaLayoutGuide.bottomAnchor, constant: .zero)
        
        toolbar.setItems([.flexibleSpace(),button,.flexibleSpace()], animated: true) // 가운데 오기 위한 space 두개
        
        
    }

    @objc func tapPlus() {
        let vc = MenuViewController()
        
        vc.modalPresentationStyle = .fullScreen
        //vc.transitioningDelegate = self
        
        self.present(vc, animated: true)
    }

}

extension ViewController : UIViewControllerTransitioningDelegate {
    
}

