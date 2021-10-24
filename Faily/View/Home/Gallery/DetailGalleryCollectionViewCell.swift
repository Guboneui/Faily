//
//  DetailGalleryCollectionViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/10/25.
//

import UIKit

class DetailGalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photo.frame = self.bounds
    }
}
