//
//  EmoticonBoxViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/08.
//

import UIKit


class MakeEmoticonViewController: UIViewController {

    
    @IBOutlet weak var designBottomView: UIView!
    @IBOutlet weak var designCollectionView: UICollectionView!
    
    let imageArr = ["sick_big", "happy_big", "mumu_big", "sad_big", "angry_big"]
    
    var selectedIndexPath: IndexPath = [] {
        didSet {
            designCollectionView.reloadData()
        }
    }
    
    var seletedIndexItem: Int = -1
    
    override func loadView() {
        super.loadView()
        
        designBottomView.layer.cornerRadius = 20
        designBottomView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
            
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setCollectionView()
    }
    
    func setCollectionView() {
        self.designCollectionView.delegate = self
        self.designCollectionView.dataSource = self
        self.designCollectionView.register(UINib(nibName: "MakeEmoticonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MakeEmoticonCollectionViewCell")
        
        
    }
    
    
   
    @IBAction func selectedButtonAction(_ sender: Any) {
        if self.seletedIndexItem == -1 {
            self.presentAlert(title: "디자인을 선택 해주세요.")
        } else {
            let storyBoard = UIStoryboard(name: "Home", bundle: nil)
            let popUpVC = storyBoard.instantiateViewController(withIdentifier: "EmoticonPopUpViewController") as! EmoticonPopUpViewController
            popUpVC.modalPresentationStyle = .overCurrentContext
            popUpVC.backGroundImageName = imageArr[seletedIndexItem]
            self.present(popUpVC, animated: false, completion: nil)
        }
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    

}

extension MakeEmoticonViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MakeEmoticonCollectionViewCell", for: indexPath) as! MakeEmoticonCollectionViewCell
        
        
        var borderColor: CGColor = UIColor.clear.cgColor
        var borderWidth: CGFloat = 0
        
        if indexPath == self.selectedIndexPath {
            borderColor = UIColor.FailyColor.mainPinkColor.cgColor
            borderWidth = 3
        } else {
            borderColor = UIColor.clear.cgColor
            borderWidth = 0
        }
        
        cell.designImageView.layer.borderWidth = borderWidth
        cell.designImageView.layer.borderColor = borderColor
        cell.designImageView.image = UIImage(named: self.imageArr[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.allowsMultipleSelection = false
        selectedIndexPath = indexPath
        seletedIndexItem = indexPath.item
        
    }
    
    
}

extension MakeEmoticonViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = designCollectionView.frame.width
        let itemsPerRow: CGFloat = 3
        let widthPadding = 12 * (itemsPerRow + 1)
        let cellWidth = (width - widthPadding) / itemsPerRow
        return CGSize(width: cellWidth, height: cellWidth)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
