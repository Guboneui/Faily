//
//  PresentDetailViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/23.
//

import UIKit

class PresentDetailViewController: UIViewController {

    @IBOutlet weak var naviTitleLabel: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var bmCollectionView: UICollectionView!
    
    let category = ["전체", "남성", "여성", "청소년"]
    
    var getNaviTitle: String?
    var getCategoryIndex: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        naviTitleLabel.text = getNaviTitle
        setCollectionView()
    }
    
    func setCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(UINib(nibName: "PresentCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PresentCategoryCollectionViewCell")
        
        bmCollectionView.delegate = self
        bmCollectionView.dataSource = self
        bmCollectionView.register(UINib(nibName: "MainBMCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainBMCollectionViewCell")
        
    }
    

    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension PresentDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return category.count
        } else if collectionView == bmCollectionView {
            return 10
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PresentCategoryCollectionViewCell", for: indexPath) as! PresentCategoryCollectionViewCell
            cell.titleLabel.text = category[indexPath.item]
            if indexPath.item == self.getCategoryIndex {
                cell.bgView.backgroundColor = UIColor.FailyColor.mainPinkColor
            } else {
                cell.bgView.backgroundColor = UIColor.white
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainBMCollectionViewCell", for: indexPath) as! MainBMCollectionViewCell
            
            if indexPath.item == 3 {
                cell.titleLabel.text = "이름"
            }
            return cell
        }
       
    }
    
    
}

extension PresentDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == categoryCollectionView {
            return CGSize(width: 67, height: 43)
        } else {
            
            let size = bmCollectionView.frame.width / 2 - 12.5
            
            return CGSize(width: size, height: size * 1.64)
        }
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        
        
        if collectionView == categoryCollectionView {
            return 20
        } else {
            return 25
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        
        if collectionView == categoryCollectionView {
            return 20
        } else {
            return 25
        }
        
    }
}
