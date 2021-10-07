//
//  MyPresentBoxTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/10/07.
//

import UIKit

class MyPresentBoxTableViewCell: UITableViewCell {

    @IBOutlet weak var myPresentBoxCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCollectionView()
    }
    
    func setCollectionView() {
        myPresentBoxCollectionView.delegate = self
        myPresentBoxCollectionView.dataSource = self
        myPresentBoxCollectionView.register(UINib(nibName: "MyPresentBoxCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyPresentBoxCollectionViewCell")
        
    }
    
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MyPresentBoxTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPresentBoxCollectionViewCell", for: indexPath) as! MyPresentBoxCollectionViewCell
        print("컬렉션뷰")
        print(cell.presentImage.frame.size)
        return cell
    }
    
    
}

extension MyPresentBoxTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        let height = self.myPresentBoxCollectionView.frame.height
        let width = height * 0.6
        
        return CGSize(width: width, height: height)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        
        return 30
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
