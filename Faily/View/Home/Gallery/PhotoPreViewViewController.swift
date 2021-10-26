//
//  PhotoPreViewViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/25.
//

import UIKit

class PhotoPreViewViewController: UIViewController {
    
    @IBOutlet weak var heartImage: UIButton!
    @IBOutlet weak var previewCollectionView: UICollectionView!
    @IBOutlet weak var allPhotoPreviewCollectionView: UICollectionView!
    
    var imageArr = ["sick_big", "happy_big", "mumu_big", "sad_big", "angry_big"]
    var getPhotoArray: [photoInfo] = []
    
    var isHeart: Int = 0 {
        didSet {
            if getPhotoArray[isHeart].isLoved == true {
                self.heartImage.setImage(UIImage(named: "gallery_heart_fill"), for: .normal)
            } else {
                self.heartImage.setImage(UIImage(named: "album_heart_empty"), for: .normal)
            }
        }
    }
    
    var passedIndexPath: IndexPath = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        
        
        
    }
    
    var index: Int = 0
    
    func setCollectionView() {
        self.previewCollectionView.delegate = self
        self.previewCollectionView.dataSource = self
        self.previewCollectionView.register(UINib(nibName: "PhotoPreviewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoPreviewCollectionViewCell")
        print("전달된 index = \(self.index)")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.previewCollectionView.collectionViewLayout = layout
        
        self.previewCollectionView.isPagingEnabled = false
        self.previewCollectionView.layoutIfNeeded()
        self.previewCollectionView.scrollToItem(at: IndexPath(item: self.index, section: 0), at: .centeredHorizontally, animated: false)
        self.previewCollectionView.isPagingEnabled = true
        
        
        
        self.allPhotoPreviewCollectionView.delegate = self
        self.allPhotoPreviewCollectionView.dataSource = self
        self.allPhotoPreviewCollectionView.register(UINib(nibName: "AllPhotoPreviewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AllPhotoPreviewCollectionViewCell")
        
        
        
        
        
        
        
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension PhotoPreViewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.getPhotoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.previewCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoPreviewCollectionViewCell", for: indexPath) as! PhotoPreviewCollectionViewCell
            cell.image.image = self.getPhotoArray[indexPath.item].photoName
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllPhotoPreviewCollectionViewCell", for: indexPath) as! AllPhotoPreviewCollectionViewCell
            cell.photoView.image = self.getPhotoArray[indexPath.item].photoName
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.allPhotoPreviewCollectionView {
            self.previewCollectionView.isPagingEnabled = false
            self.previewCollectionView.layoutIfNeeded()
            self.previewCollectionView.scrollToItem(at: IndexPath(item: indexPath.item, section: 0), at: .centeredHorizontally, animated: false)
            self.previewCollectionView.isPagingEnabled = true
            
        }
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let currentPage = Int(x / previewCollectionView.frame.width)
        print("currentpage = \(currentPage)")
        self.isHeart = currentPage

    }
    
    
    
    
}

extension PhotoPreViewViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.previewCollectionView {
            return self.previewCollectionView.frame.size
        } else {
            return CGSize(
                width: self.allPhotoPreviewCollectionView.frame.height,
                height: self.allPhotoPreviewCollectionView.frame.height
            )
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.previewCollectionView {
            return 0
        } else {
            return 5
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.previewCollectionView {
            return 0
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.allPhotoPreviewCollectionView {
            let totalCellWidth: CGFloat = self.allPhotoPreviewCollectionView.frame.height * CGFloat(self.getPhotoArray.count)
            let totalSpacingWidth = 5
            
            let leftInset: CGFloat = (self.allPhotoPreviewCollectionView.frame.width - CGFloat(totalCellWidth + CGFloat(totalSpacingWidth))) / 2
            let rightInset = leftInset
            
            return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}
