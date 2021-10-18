//
//  FamilyScheduleTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/10/19.
//

import UIKit

class FamilyScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var familyScheduleBaseView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        familyScheduleBaseView.layer.cornerRadius = 15
        familyScheduleBaseView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
