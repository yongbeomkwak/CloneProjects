//
//  ViewController.swift
//  PhotoScroll
//
//  Created by yongbeomkwak on 2/6/24.
//

import UIKit

class ViewController: UIViewController {

    fileprivate let photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    
    var layout:UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout()
       
        layout.itemSize = CGSize(width: 70.0, height: 70.0)
        layout.sectionInset =  UIEdgeInsets(top: 10, left: 5.0, bottom: 10.0, right: 5.0)
        
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        
        view.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.id)
        
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(collectionView)
        
        collectionView.fillSuperview()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    
}

extension ViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.navigationController?.pushViewController(ZoomedPhotoViewController(photoName: photos[indexPath.row]), animated: true)
    }
    
}

extension ViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.id, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        
        let fullSizedImage = UIImage(named: photos[indexPath.row])
        
        
        cell.update(fullSizedImage!.thumbnailOfSize(70))
        
        return cell
    }
    
    
}

