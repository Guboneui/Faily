//
//  GalleryCategoryCollectionViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/10/26.
//

import UIKit

class GalleryCategoryCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var heartImage: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
