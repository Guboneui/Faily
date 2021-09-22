//
//  RecommentCollectionViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/09/23.
//

import UIKit

class RecommentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageBaseView: UIView!
    @IBOutlet weak var giftImage: UIImageView!
    @IBOutlet weak var giftTitle: UILabel!
    @IBOutlet weak var giftPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configUI()
    }
    
    func configUI() {
        giftImage.layer.cornerRadius = 20
        imageBaseView.layer.cornerRadius = 20
        imageBaseView.layer.shadowOpacity = 0.33
        imageBaseView.layer.shadowOffset = CGSize(width: 0, height: 4)
        imageBaseView.layer.shadowColor = UIColor.FailyColor.grayscale_4.cgColor
    }

}
