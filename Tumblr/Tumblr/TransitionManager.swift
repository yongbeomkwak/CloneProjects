//
//  TransitionManager.swift
//  Tumblr
//
//  Created by yongbeomkwak on 2/11/24.
//

import UIKit

class TransitionManager : NSObject {
    
    fileprivate var presenting = false
    
}


//view controller를 전환할 때 커스텀으로 애니메이션을 주고싶다면 이것을 구현하래요
extension TransitionManager : UIViewControllerAnimatedTransitioning {
    
    // 애니메이션 동작시간
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.5
    }
    
    // 애니메이션 효과정의
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // 뷰를 담을 수 있는 전체 틀이라고 생각하면되요!
        let container = transitionContext.containerView
        
        // create a tuple of our screens
        let screens : (from:UIViewController, to:UIViewController) = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!, transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!)
        
        
        // assign references to our menu view controller and the 'bottom' view controller from the tuple
        // remember that our menuViewController will alternate between the from and to view controller depending if we're presenting or dismissing
        let menuViewController = !self.presenting ? screens.from as! MenuViewController : screens.to as! MenuViewController
        let viewController = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
        
        let menuView = menuViewController.view
        let view = viewController.view
        
        // prepare the menu
        if (self.presenting){
          // prepare menu to fade in
          offStageMenuController(menuViewController)
        }
        
        // add the both views to our view controller
        container.addSubview(view!)
        container.addSubview(menuView!)
        
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
          
          if (self.presenting){
            self.onStageMenuController(menuViewController) // onstage items: slide in
          }
          else {
            self.offStageMenuController(menuViewController) // offstage items: slide out
          }
          
          }, completion: { finished in
            transitionContext.completeTransition(true)
            UIApplication.shared.keyWindow?.addSubview(screens.to.view)
            
        })
        
    }
    
    func offStage(_ amount: CGFloat) -> CGAffineTransform {
      return CGAffineTransform(translationX: amount, y: 0)
    }
    
    func offStageMenuController(_ menuViewController: MenuViewController){
      
      menuViewController.view.alpha = 0
      
      // setup paramaters for 2D transitions for animations
      let topRowOffset  :CGFloat = 300
      let middleRowOffset :CGFloat = 150
      let bottomRowOffset  :CGFloat = 50
      
      menuViewController.textPostIcon.transform = self.offStage(-topRowOffset)
      menuViewController.textPostLabel.transform = self.offStage(-topRowOffset)
      
      menuViewController.quotePostIcon.transform = self.offStage(-middleRowOffset)
      menuViewController.quotePostLabel.transform = self.offStage(-middleRowOffset)
      
      menuViewController.chatPostIcon.transform = self.offStage(-bottomRowOffset)
      menuViewController.chatPostLabel.transform = self.offStage(-bottomRowOffset)
      
      menuViewController.photoPostIcon.transform = self.offStage(topRowOffset)
      menuViewController.photoPostLabel.transform = self.offStage(topRowOffset)
      
      menuViewController.linkPostIcon.transform = self.offStage(middleRowOffset)
      menuViewController.linkPostLabel.transform = self.offStage(middleRowOffset)
      
      menuViewController.audioPostIcon.transform = self.offStage(bottomRowOffset)
      menuViewController.audioPostLabel.transform = self.offStage(bottomRowOffset)
      
    }
    
    func onStageMenuController(_ menuViewController: MenuViewController){
      
      // prepare menu to fade in
      menuViewController.view.alpha = 1
      
    //CGAffineTransform.identity = 적용된 변환 제거
      menuViewController.textPostIcon.transform = CGAffineTransform.identity
      menuViewController.textPostLabel.transform = CGAffineTransform.identity
      
      menuViewController.quotePostIcon.transform = CGAffineTransform.identity
      menuViewController.quotePostLabel.transform = CGAffineTransform.identity
      
      menuViewController.chatPostIcon.transform = CGAffineTransform.identity
      menuViewController.chatPostLabel.transform = CGAffineTransform.identity
      
      menuViewController.photoPostIcon.transform = CGAffineTransform.identity
      menuViewController.photoPostLabel.transform = CGAffineTransform.identity
      
      menuViewController.linkPostIcon.transform = CGAffineTransform.identity
      menuViewController.linkPostLabel.transform = CGAffineTransform.identity
      
      menuViewController.audioPostIcon.transform = CGAffineTransform.identity
      menuViewController.audioPostLabel.transform = CGAffineTransform.identity
      
    }
    
    
}

// 뷰 컨트롤러 간의 전환을 관리하는 데 사용되는 Delegate같아요
extension TransitionManager : UIViewControllerTransitioningDelegate {
    
    // present될때 실행애니메이션
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.presenting = true
        return self
    }
    
    // dismiss될때 실행애니메이션
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
}
