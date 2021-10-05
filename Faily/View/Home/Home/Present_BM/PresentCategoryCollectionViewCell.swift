//
//  PresentCategoryCollectionViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/09/23.
//

import UIKit

class PresentCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var bgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configUI()
    }

    func configUI() {
        baseView.layer.cornerRadius = 15
        bgView.layer.cornerRadius = 15
        baseView.layer.shadowColor = UIColor.FailyColor.grayscale_4.cgColor
        baseView.layer.shadowOffset = CGSize(width: 0, height: 4)
        baseView.layer.shadowOpacity = 0.33
    }

}
