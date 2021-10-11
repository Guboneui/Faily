//
//  MyMessageTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/10/12.
//

import UIKit

class MyMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var myMessageLabel: UILabel!
    @IBOutlet weak var messageBaseView: UIView!
    
    override func layoutSubviews() {
        layoutIfNeeded()
        messageBaseView.clipsToBounds = true
        messageBaseView.layer.cornerRadius = 15
        messageBaseView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
            
        

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

