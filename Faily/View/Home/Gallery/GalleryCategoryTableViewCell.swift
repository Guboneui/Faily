//
//  GalleryCategoryTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/10/25.
//

import UIKit

class GalleryCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        thumbnailImage.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
