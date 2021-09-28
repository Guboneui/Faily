//
//  MainQuestionCollectionViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/09/27.
//

import UIKit
import CollectionViewPagingLayout

class MainQuestionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var questionBox: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerStackView: UIStackView!
    @IBOutlet weak var answerStackViewLabel: UILabel!
    @IBOutlet weak var answerStackViewImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goAnswerView))
        answerStackView.addGestureRecognizer(tapGesture)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @objc func goAnswerView(_ recognizer: UITapGestureRecognizer) {
        if answerStackViewLabel.text == "답변하러 가기" {
            let storyBoard = UIStoryboard(name: "Home", bundle: nil)
            let qaVC = storyBoard.instantiateViewController(withIdentifier: "QAViewController")
            qaVC.modalPresentationStyle = .overCurrentContext
            self.window?.rootViewController?.present(qaVC, animated: true, completion: nil)
            
        } else if answerStackViewLabel.text == "답변보러 가기" {
            let storyBoard = UIStoryboard(name: "Home", bundle: nil)
            let allAnswerVC = storyBoard.instantiateViewController(withIdentifier: "AllAnswerViewController")
            allAnswerVC.modalPresentationStyle = .overCurrentContext
            self.window?.rootViewController?.present(allAnswerVC, animated: true, completion: nil)
        }
    }
}



extension MainQuestionCollectionViewCell: ScaleTransformView {
    var scaleOptions: ScaleTransformViewOptions {
        .layout(.linear)
    }
}
