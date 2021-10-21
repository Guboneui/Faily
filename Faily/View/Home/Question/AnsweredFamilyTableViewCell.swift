//
//  AnsweredFamilyTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/09/27.
//

import UIKit

class AnsweredFamilyTableViewCell: UITableViewCell {

    @IBOutlet weak var answeredFamilyCountImage: UIImageView!
    @IBOutlet weak var answeredCollectionView: UICollectionView!
    
    var answeredFamilyCount: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        answeredCollectionView.delegate = self
        answeredCollectionView.dataSource = self
        answeredCollectionView.register(UINib(nibName: "AnsweredFamilyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AnsweredFamilyCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
       
    }
    
}


extension AnsweredFamilyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("AnsweredFamilyTableViewCell - answeredFamilyCount ====== \(self.answeredFamilyCount)")
        return self.answeredFamilyCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnsweredFamilyCollectionViewCell", for: indexPath) as! AnsweredFamilyCollectionViewCell
        
        return cell
    }
    
    
}

extension AnsweredFamilyTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = self.answeredCollectionView.frame.width
        let cellHeight = self.answeredCollectionView.frame.height
        return CGSize(width: cellWidth * 0.12, height: cellHeight)
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        
       return 20
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
        
    }
    
    
    
}
