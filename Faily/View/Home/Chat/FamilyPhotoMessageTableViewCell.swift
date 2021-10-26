//
//  FamilyPhotoMessageTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/10/19.
//

import UIKit

class FamilyPhotoMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var familySendImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        familySendImage.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
