//
//  EmoticonBoxViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/08.
//

import UIKit
import SwiftyImage

class MakeEmoticonViewController: UIViewController {

    
    @IBOutlet weak var userSelectedImageView: UIImageView!
    @IBOutlet weak var designBottomView: UIView!
    @IBOutlet weak var designCollectionView: UICollectionView!
    @IBOutlet weak var selectPhotoStackView: UIStackView!
    
    var imageArr = ["testBG1", "testBG2", "testBG3", "testBG4", "testBG5", "testBG6"]
    
    
    var seletedImage: UIImage?
    var seletedBackGround: UIImage?
    
    
    var selectedIndexPath: IndexPath = [] {
        didSet {
            designCollectionView.reloadData()
        }
    }
    
    let picker = UIImagePickerController()
    
    var seletedIndexItem: Int = -1
    var userSelectedState: Bool = false
    
    override func loadView() {
        super.loadView()
        
        designBottomView.layer.cornerRadius = 20
        designBottomView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
            
        userSelectedImageView.layer.borderWidth = 1
        userSelectedImageView.layer.borderColor = UIColor.FailyColor.grayscale_5.cgColor
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setCollectionView()
        picker.delegate = self
        
        let selectPhotoTapGesture = UITapGestureRecognizer(target: self, action: #selector(selectPhotoTapAction))
        selectPhotoStackView.isUserInteractionEnabled = true
        selectPhotoStackView.addGestureRecognizer(selectPhotoTapGesture)
    }
    
    @objc func selectPhotoTapAction(_ sender: UITapGestureRecognizer) {
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func setCollectionView() {
        self.designCollectionView.delegate = self
        self.designCollectionView.dataSource = self
        self.designCollectionView.register(UINib(nibName: "MakeEmoticonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MakeEmoticonCollectionViewCell")
        
        
    }
    
    
   
    @IBAction func selectedButtonAction(_ sender: Any) {
        
        if self.userSelectedState == false {
            self.presentAlert(title: "적용할 이미지를 선택 해주세요.")
        } else {
            if self.seletedIndexItem == -1 {
                self.presentAlert(title: "디자인을 선택 해주세요.")
            } else {
                let storyBoard = UIStoryboard(name: "Home", bundle: nil)
                let popUpVC = storyBoard.instantiateViewController(withIdentifier: "EmoticonPopUpViewController") as! EmoticonPopUpViewController
                popUpVC.modalPresentationStyle = .overCurrentContext
                self.seletedBackGround = UIImage(named: imageArr[seletedIndexItem])
                //popUpVC.backGroundImageName = imageArr[seletedIndexItem]
                
                guard var userSelectedImage = self.seletedImage, var userSelectedBackGround = self.seletedBackGround else {
                    return
                }
                
                let combinedImage = userSelectedImage + userSelectedBackGround
                //let combinedImage = userSelectedImage + UIImage(named: "TestPng")!
                popUpVC.combinedImage = combinedImage
                
                
                
                self.present(popUpVC, animated: false, completion: nil)
            }
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
            borderColor = UIColor.white.cgColor
            borderWidth = 1
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

extension MakeEmoticonViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            userSelectedImageView.image = image
            self.seletedImage = image
        }
        self.userSelectedState = true
        
        dismiss(animated: true, completion: nil)
    }
}
