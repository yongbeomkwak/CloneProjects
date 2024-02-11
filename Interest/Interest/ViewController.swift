//
//  ViewController.swift
//  Interest
//
//  Created by yongbeomkwak on 2/9/24.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var interests = Interest.createInterests()
    
    var backgroundImageView : UIImageView = {
        
        let view = UIImageView()
        view.contentMode = .scaleToFill
        
        return view
    }()
    
    var visualEffectView : UIVisualEffectView = {
        
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        
        return view
    }()
    
    var flowLayout: UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = .init(width: 280, height: 380)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .init(top: .zero, left: 20, bottom: .zero, right: 20)
        
        layout.scrollDirection = .horizontal
        
        return layout
        
    }()
    
    
    lazy var collectionView: UICollectionView = {
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
       
        
        view.register(InterestCollectionViewCell.self, forCellWithReuseIdentifier: InterestCollectionViewCell.id)
        
        
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        backgroundImageView.image = UIImage(named: "r1")
        collectionView.dataSource = self
        
        self.view.addSubviews(backgroundImageView,visualEffectView)
        
        visualEffectView.contentView.addSubviews(collectionView)
        
        backgroundImageView.fillSuperview()
        visualEffectView.fillSuperview()
        
        collectionView.backgroundColor = .clear
        collectionView.setHorizon(constant: .zero)
        collectionView.setVertical(constant: 80)
        
        
    }


}



extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestCollectionViewCell.id, for: indexPath) as? InterestCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.interest = interests[indexPath.row]
        
        return cell
        
    }
    
    
}

// MARK: - UIScrollViewDelegate
extension ViewController: UIScrollViewDelegate {
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    let cellWidthWithSpace = layout.itemSize.width + layout.minimumLineSpacing
    
    
    var offset = targetContentOffset.pointee
    
    print("\(targetContentOffset) \(targetContentOffset.pointee)")
      
    let index = (offset.x + scrollView.contentInset.left) / cellWidthWithSpace
    let roundedIndex = round(index)
    
    offset = CGPoint(x: roundedIndex * cellWidthWithSpace - scrollView.contentInset.left, y: -scrollView.contentInset.top)
  }
}


