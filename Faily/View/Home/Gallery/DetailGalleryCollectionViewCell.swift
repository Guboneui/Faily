//
//  DetailGalleryCollectionViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/10/25.
//

import UIKit

class DetailGalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var heart: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photo.frame = self.bounds
        photo.layer.borderColor = UIColor.FailyColor.grayscale_5.cgColor
        photo.layer.borderWidth = 0.2
    }
}
