//
//  EachAnswerTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/10/02.
//

import UIKit

class EachAnswerTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editAnswerButtonAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let editQAVC = storyBoard.instantiateViewController(withIdentifier: "QAViewController")
        editQAVC.modalPresentationStyle = .overCurrentContext
        self.window?.rootViewController?.present(editQAVC, animated: true, completion: nil)
    }
}
