//
//  OnBoardingCollectionViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/09/15.
//

import UIKit

struct OnBoarding {
    var imageName: String
    var titleText: String
}

class OnBoardingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var onBoardings = [
        OnBoarding(imageName: "camera", titleText: "채팅"),
        OnBoarding(imageName: "camera", titleText: "질문"),
        OnBoarding(imageName: "camera", titleText: "갤러리"),
        OnBoarding(imageName: "camera", titleText: "캘린더")
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(index: Int) {
        let onBoarding: OnBoarding = onBoardings[index]
        imageView.image = UIImage(named: onBoarding.imageName)
        titleLabel.text = onBoarding.titleText
    }

}
