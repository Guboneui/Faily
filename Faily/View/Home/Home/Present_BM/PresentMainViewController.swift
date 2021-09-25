//
//  PresentMainViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/23.
//

import UIKit

class PresentMainViewController: UIViewController {
    
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var topBannerBaseView: UIView!
    @IBOutlet weak var topBannerBGView: UIImageView!
    @IBOutlet weak var recommentBaseView: UIView!
    @IBOutlet weak var recommentBGView: UIImageView!
    @IBOutlet weak var recommentCollectionView: UICollectionView!
    
    let category = ["전체", "남성", "여성", "청소년"]
    
    override func loadView() {
        super.loadView()
        configUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        
    }
    
    func configUI() {
        topBannerBaseView.layer.cornerRadius = 20
        makeShadow(topBannerBaseView)
        topBannerBGView.layer.cornerRadius = 20
        
        recommentBaseView.layer.cornerRadius = 20
        makeShadow(recommentBaseView)
        recommentBGView.layer.cornerRadius = 20
        
    }
    
    func setCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(UINib(nibName: "PresentCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PresentCategoryCollectionViewCell")
        
        recommentCollectionView.delegate = self
        recommentCollectionView.dataSource = self
        recommentCollectionView.register(UINib(nibName: "RecommentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecommentCollectionViewCell")
        
        //categoryCollectionView.collectionViewLayout = 컴포넌트 레이아웃
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension PresentMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == categoryCollectionView {
            return category.count
        } else {
            return 10
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PresentCategoryCollectionViewCell", for: indexPath) as! PresentCategoryCollectionViewCell
            cell.titleLabel.text = category[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommentCollectionViewCell", for: indexPath) as! RecommentCollectionViewCell
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let storyBoard = UIStoryboard(name: "Home", bundle: nil)
            let detailPresentVC = storyBoard.instantiateViewController(withIdentifier: "PresentDetailViewController") as! PresentDetailViewController
            
            detailPresentVC.getNaviTitle = category[indexPath.item]
            detailPresentVC.getCategoryIndex = indexPath.item
            self.navigationController?.pushViewController(detailPresentVC, animated: true)
        }
        
        
        
        
    }
    
    
}

extension PresentMainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == categoryCollectionView {
            return CGSize(width: 67, height: 43)
        } else {
            
            let size = recommentCollectionView.frame.height
            
            return CGSize(width: size * 0.63, height: size)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        
        
        if collectionView == categoryCollectionView {
            return 20
        } else {
            return 30
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        
        if collectionView == categoryCollectionView {
            return 20
        } else {
            return 30
        }
    }
}
