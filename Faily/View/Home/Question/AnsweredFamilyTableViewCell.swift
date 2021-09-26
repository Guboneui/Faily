//
//  AnsweredFamilyTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/09/27.
//

import UIKit

class AnsweredFamilyTableViewCell: UITableViewCell {

    @IBOutlet weak var answeredCollectionView: UICollectionView!
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
    
}


extension AnsweredFamilyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnsweredFamilyCollectionViewCell", for: indexPath) as! AnsweredFamilyCollectionViewCell
        
        return cell
    }
    
    
}

extension AnsweredFamilyTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let cellHeight = self.answeredCollectionView.frame.height
        return CGSize(width: cellHeight * 0.65, height: cellHeight)
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        
       return 30
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
        
    }
    
    
    
}
