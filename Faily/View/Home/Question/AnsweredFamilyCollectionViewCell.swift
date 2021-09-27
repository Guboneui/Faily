//
//  AnsweredFamilyCollectionViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/09/27.
//

import UIKit

class AnsweredFamilyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var familyProfileImage: UIImageView!
    
    
       override func awakeFromNib() {
           super.awakeFromNib()
           
       }
       
       override func layoutSubviews() {
           super.layoutSubviews()
           configUI()
       }
    
    func configUI() {
        layoutIfNeeded() 
        self.familyProfileImage.layer.cornerRadius = self.familyProfileImage.frame.height / 2
    }
    
}
