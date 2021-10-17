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
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let popUpVC = storyBoard.instantiateViewController(withIdentifier: "EmoticonPopUpViewController") as! EmoticonPopUpViewController
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.present(popUpVC, animated: false, completion: nil)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    

}

extension MakeEmoticonViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MakeEmoticonCollectionViewCell", for: indexPath) as! MakeEmoticonCollectionViewCell
        return cell
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
