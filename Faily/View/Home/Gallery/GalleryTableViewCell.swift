//
//  GalleryTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/10/11.
//

import UIKit

class GalleryTableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
