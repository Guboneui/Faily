//
//  MyScheduleTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/10/19.
//

import UIKit

class MyScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var myScheduleBaseView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        myScheduleBaseView.layer.cornerRadius = 15
        myScheduleBaseView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
