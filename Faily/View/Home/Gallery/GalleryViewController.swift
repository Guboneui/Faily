//
//  GalleryViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/16.
//

import UIKit
import Photos

class GalleryViewController: UIViewController {
    
    
    //@IBOutlet weak var galleryCategoryTableView: UITableView!
    @IBOutlet weak var galleryCategoryCollectionView: UICollectionView!
    let sectionInsets = UIEdgeInsets(top: 15, left: 32, bottom: 15, right: 32)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setCollectionView()
    }

    
    func setCollectionView() {
        galleryCategoryCollectionView.delegate = self
        galleryCategoryCollectionView.dataSource = self
        galleryCategoryCollectionView.register(UINib(nibName: "GalleryCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCategoryCollectionViewCell")
        
    }
    
    
    
    
    
    
    
    //
    //    @IBAction func addGalleryCategoryAction(_ sender: Any) {
    //        let alert = UIAlertController(title: "갤러리", message: "추가할 카테고리 이름을 입력 해주세요.", preferredStyle: .alert)
    //        alert.addTextField { textField in
    //            textField.placeholder = "카테고리"
    //        }
    //        let cancelButton = UIAlertAction(title: "취소", style: .default, handler: nil)
    //        let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
    //        alert.addAction(cancelButton)
    //        alert.addAction(okButton)
    //        self.present(alert, animated: true, completion: nil)
    //    }
    //
    
}



extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    //    func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        <#code#>
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCategoryCollectionViewCell", for: indexPath) as! GalleryCategoryCollectionViewCell
        return cell
    }
    
    
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.galleryCategoryCollectionView.frame.width
        let height = self.galleryCategoryCollectionView.frame.height
        let itemsPerRow: CGFloat = 2
        let widthPadding = sectionInsets.left * (3)
        let itemsPerColumn: CGFloat = 2
        let heightPadding = sectionInsets.top * (3)
        let cellWidth = (width - widthPadding) / itemsPerRow
        let cellHeight = (height - heightPadding) / itemsPerColumn
        
        return CGSize(width: cellWidth, height: cellWidth * 1.34375)
     
        
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.sectionInsets
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.bottom
    }
    ////
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.bottom
    }
    
    
}
