//
//  PresentDetailViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/23.
//

import UIKit

struct BMDetail {
    let image: String
    let name: String
    let price: String
    let star: Double
    let review: String
}

class PresentDetailViewController: UIViewController {

    @IBOutlet weak var naviTitleLabel: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var bmCollectionView: UICollectionView!
    
    let category = ["전체", "남성", "여성", "청소년"]
    
    
    var bmArr: [BMDetail] = [
        BMDetail(image: "bm1", name: "비타민", price: "32,000원", star: 4.2, review: "78"),
        BMDetail(image: "bm2", name: "니트", price: "27,000원", star: 4.5, review: "188"),
        BMDetail(image: "bm3", name: "홍삼 세트", price: "112,000원", star: 4.7, review: "12"),
        BMDetail(image: "bm4", name: "스타벅스 텀블러 세트", price: "27,500원", star: 4.1, review: "98"),
        BMDetail(image: "bm5", name: "나이키 ", price: "29,000원", star: 3.9, review: "152"),
        BMDetail(image: "bm6", name: "생로랑 장지갑", price: "732,000원", star: 4.9, review: "45"),
        BMDetail(image: "bm7", name: "구찌 스네이크 지갑", price: "529,900원", star: 4.9, review: "23"),
        BMDetail(image: "bm1", name: "비타민", price: "32,000원", star: 4.2, review: "78"),
        BMDetail(image: "bm2", name: "니트", price: "27,000원", star: 4.5, review: "188"),
        BMDetail(image: "bm3", name: "홍삼 세트", price: "112,000원", star: 4.7, review: "12"),
        BMDetail(image: "bm4", name: "스타벅스 텀블러 세트", price: "27,500원", star: 4.1, review: "98"),
        BMDetail(image: "bm5", name: "나이키 ", price: "29,000원", star: 3.9, review: "152"),
        BMDetail(image: "bm6", name: "생로랑 장지갑", price: "732,000원", star: 4.9, review: "45"),
        BMDetail(image: "bm7", name: "구찌 스네이크 지갑", price: "529,900원", star: 4.9, review: "23"),
    ]
    
    
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
            return self.bmArr.count
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
            
            let data = self.bmArr[indexPath.item]
            
            cell.titleLabel.text = data.name
            cell.imageView.image = UIImage(named: data.image)
            cell.priceLabel.text = data.price
            cell.ratingView.rating = data.star
            cell.ratingView.text = "(\(data.review))"
            
            
            
            return cell
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            self.getCategoryIndex = indexPath.item
            self.categoryCollectionView.reloadData()
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
