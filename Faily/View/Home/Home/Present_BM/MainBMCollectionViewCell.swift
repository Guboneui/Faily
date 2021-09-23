//
//  MainBMCollectionViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/09/24.
//

import UIKit
import Cosmos

class MainBMCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ratingView.settings.fillMode = .precise
    }

}
