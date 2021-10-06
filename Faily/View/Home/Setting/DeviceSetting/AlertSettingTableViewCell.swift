//
//  AlertSettingTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/10/06.
//

import UIKit

class AlertSettingTableViewCell: UITableViewCell {

    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var alertStateSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        alertStateSwitch.transform = CGAffineTransform(scaleX: 0.8, y: 0.75)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
