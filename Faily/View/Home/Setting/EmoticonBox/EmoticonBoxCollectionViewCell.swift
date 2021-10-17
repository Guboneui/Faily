//
//  EmoticonBoxCollectionViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/10/18.
//

import UIKit

class EmoticonBoxCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var emoticonImageView: UIImageView!
    @IBOutlet weak var deleteImage: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        emoticonImageView.layer.cornerRadius = 10
        emoticonImageView.layer.masksToBounds = true
        baseView.layer.cornerRadius = 10
        baseView.layer.shadowColor = UIColor.FailyColor.grayscale_4.cgColor
        baseView.layer.shadowOpacity = 0.33
        baseView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        
    }
}
