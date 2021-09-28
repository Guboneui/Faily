//
//  AllAnswerProfileCollectionViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/09/29.
//

import UIKit

class AllAnswerProfileCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var familyProfileImage: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        familyProfileImage.layer.cornerRadius = familyProfileImage.frame.height / 2
    }
    
}
