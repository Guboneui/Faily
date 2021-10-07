//
//  MyPresentOrderDetailTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/10/07.
//

import UIKit

class MyPresentOrderDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var myPresentImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        baseView.layer.cornerRadius = 10
        baseView.layer.shadowColor = UIColor.FailyColor.grayscale_4.cgColor
        baseView.layer.shadowOpacity = 0.33
        baseView.layer.shadowOffset = CGSize(width: 0, height: 4)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
