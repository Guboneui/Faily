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
    var contentsText: String
}

class OnBoardingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    
    var onBoardings = [
        OnBoarding(imageName: "onBoarding_Chat", titleText: "가족 모두가 함께하는 채팅", contentsText: "채팅을 따로 개설할 필요가 없어요. 페일리의 채팅에서 자유롭게 일상의 대화를 나눠 보세요."),
        OnBoarding(imageName: "onBoarding_Question", titleText: "매일 주어지는 질문", contentsText: "같은 질문이 가족들에게 전달됩니다. 서로의 답변을 확인하고 이에 대해 이야기 해보세요."),
        OnBoarding(imageName: "onBoarding_Emoticon", titleText: "이모티콘", contentsText: "채팅방에서 쓰인 사진이 이모티콘으로 제작됩니다. 각자의 얼굴이 담긴 이모티콘을 사용해 보세요."),
        OnBoarding(imageName: "onBoarding_FriendShip", titleText: "1에서 100, 가족의 유대감", contentsText: "매일 새로운 질문과 특별한 이모티콘으로 대화를 지속하여 유대감을 100%로 만들어 보세요.")
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(index: Int) {
        let onBoarding: OnBoarding = onBoardings[index]
        imageView.image = UIImage(named: onBoarding.imageName)
        titleLabel.text = onBoarding.titleText
        contentsLabel.text = onBoarding.contentsText
    }

}
