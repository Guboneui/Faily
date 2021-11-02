//
//  PresentMainViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/23.
//

import UIKit

struct BM {
    let image: String
    let name: String
    let price: String
}

class PresentMainViewController: UIViewController {
    
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var topBannerBaseView: UIView!
    @IBOutlet weak var topBannerBGView: UIImageView!
    @IBOutlet weak var recommentBaseView: UIView!
    @IBOutlet weak var recommentBGView: UIImageView!
    @IBOutlet weak var recommentCollectionView: UICollectionView!
    
    let category = ["전체", "남성", "여성", "청소년"]
    
    var bmArr: [BM] = [
        BM(image: "bm1", name: "비타민", price: "32,000원"),
        BM(image: "bm2", name: "니트", price: "27,000원"),
        BM(image: "bm3", name: "홍삼 세트", price: "112,000원"),
        BM(image: "bm4", name: "스타벅스 텀블러 세트", price: "27,500원"),
        BM(image: "bm5", name: "나이키 ", price: "29,000원"),
        BM(image: "bm6", name: "생로랑 장지갑", price: "732,000원"),
        BM(image: "bm7", name: "구찌 스네이크 지갑", price: "529,900원"),
    ]
    
    //let bmArr = ["bm1", "bm2", "bm3", "bm4", "bm5", "bm6", "bm7"]
    
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
            return self.bmArr.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PresentCategoryCollectionViewCell", for: indexPath) as! PresentCategoryCollectionViewCell
            cell.titleLabel.text = category[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommentCollectionViewCell", for: indexPath) as! RecommentCollectionViewCell
            
            cell.giftImage.image = UIImage(named: self.bmArr[indexPath.item].image) 
            cell.giftTitle.text = self.bmArr[indexPath.item].name
            cell.giftPrice.text = self.bmArr[indexPath.item].price
            
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
