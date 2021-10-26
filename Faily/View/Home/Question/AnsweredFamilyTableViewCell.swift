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
    var answerInfoArray: [AnswerInfo] = []
    
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
        
       
        if answerInfoArray[indexPath.row].user_name == "원승빈" {
            cell.familyProfileImage.image = UIImage(named: "승빈_프로필")
            cell.familyNameLabel.text = "승빈"
        } else if answerInfoArray[indexPath.row].user_name == "장나연" {
            cell.familyProfileImage.image = UIImage(named: "나연_프로필")
            cell.familyNameLabel.text = "나연"
        } else if answerInfoArray[indexPath.row].user_name == "정수빈" {
            cell.familyProfileImage.image = UIImage(named: "수빈_프로필")
            cell.familyNameLabel.text = "수빈"
        } else {
            cell.familyProfileImage.image = UIImage(named: "본의_프로필")
            cell.familyNameLabel.text = "본의"
        }

        
//        
//        
//        
        
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
