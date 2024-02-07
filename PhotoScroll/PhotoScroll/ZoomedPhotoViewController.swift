//
//  ZoomedPhotoViewController.swift
//  PhotoScroll
//
//  Created by yongbeomkwak on 2/7/24.
//

import UIKit

class ZoomedPhotoViewController: UIViewController {

    
    var photoName : String!
    
    var imageView: UIImageView = {
       
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var scrollView: UIScrollView = {
        
        let view = UIScrollView()
        
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    var imageViewTopConstraint: NSLayoutConstraint!
    var imageViewBottomConstraint: NSLayoutConstraint!
    var imageViewLeadingConstraint: NSLayoutConstraint!
    var imageViewTrailingConstraint: NSLayoutConstraint!
    

    
    init(photoName: String) {
        self.photoName = photoName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        imageView.image = UIImage(named: photoName)
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        
        scrollView.fillSuperview()

        
        
        imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: .zero)
        imageViewBottomConstraint = imageView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: .zero)
        imageViewLeadingConstraint = imageView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: .zero)
        imageViewTrailingConstraint = imageView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: .zero)
        
        imageViewTopConstraint.isActive = true
        imageViewBottomConstraint.isActive = true
        imageViewLeadingConstraint.isActive = true
        imageViewTrailingConstraint.isActive = true
        
        scrollView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        
        // 뷰가 서브 뷰의 배치를 다했다는 소식을 뷰 컨트롤러에게 알립니다.
        // 뷰가 서브 뷰들의 배치를 조정한 직후에 하고 싶은 작업이 있다면 여기서 작업하면 됨
        // 즉, 레이아웃이 결정되고 나서 다음과 같은 일을 수행하고자 할 때
        // 1. 다른 뷰들의 컨텍트 업데이트
        // 2. 뷰들의 크기나 위치를 최종적으로 조정 될 때
        
       super.viewDidLayoutSubviews()
        
    
       
       updateMinZoomScale(forSize: view.bounds.size)
     }

}

extension ZoomedPhotoViewController {
    
    fileprivate func updateConstraints(forSize size: CGSize) {
      let yOffset = max(0, (size.height - imageView.frame.height) / 2)
        
        
      imageViewTopConstraint.constant = yOffset
      imageViewBottomConstraint.constant = yOffset
      
      let xOffset = max(0, (size.width - imageView.frame.width) / 2)
      imageViewLeadingConstraint.constant = xOffset
      imageViewTrailingConstraint.constant = xOffset
      
      view.layoutIfNeeded() // UIView의 위치와 크기를 재조정하는 메소드
    }

    
    fileprivate func updateMinZoomScale(forSize size: CGSize) {
      let widthScale = size.width / imageView.bounds.width
      let heightScale = size.height / imageView.bounds.height
      let minScale = min(widthScale, heightScale)
      
      scrollView.minimumZoomScale = minScale
      
      /// set up the init zoom scale
      scrollView.zoomScale = minScale
    }
    
}

extension ZoomedPhotoViewController : UIScrollViewDelegate {
    
    /// Tell the delegate that the imageView will be made smaller or bigger.
     ///
     /// - Parameter scrollView: scrollView delegate to current view controller
     /// - Returns: the view is zoomed in and out
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    /// Called every time zoom in or out the scroll View
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraints(forSize: view.bounds.size)
    }
    
}

