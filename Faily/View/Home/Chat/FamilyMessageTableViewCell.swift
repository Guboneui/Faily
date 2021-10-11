//
//  FamilyMessageTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/10/12.
//

import UIKit

class FamilyMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var messageBaseView: UIView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func layoutSubviews() {
        layoutIfNeeded()
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        
        messageBaseView.clipsToBounds = true
        messageBaseView.layer.cornerRadius = 15
        messageBaseView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
