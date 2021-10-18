//
//  FamilyPhotoMessageTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/10/19.
//

import UIKit

class FamilyPhotoMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var familySendImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        familySendImage.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
