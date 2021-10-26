//
//  MyPhotoMessageTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/10/19.
//

import UIKit

class MyPhotoMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var mySendImage: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        mySendImage.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
