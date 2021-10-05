//
//  DateScheduleTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/10/05.
//

import UIKit

class DateScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var firstBaseView: UIView!
    @IBOutlet weak var firstBGView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var secondBaseView: UIView!
    @IBOutlet weak var secondBGView: UIImageView!
    @IBOutlet weak var scheduleTitleLabel: UILabel!
    @IBOutlet weak var scheduleDetailLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        
        firstBaseView.layer.cornerRadius = 20
        firstBGView.layer.cornerRadius = 20
        firstBGView.layer.shadowColor = UIColor.FailyColor.grayscale_4.cgColor
        firstBGView.layer.shadowOpacity = 0.33
        firstBGView.layer.shadowOffset = CGSize(width: 0, height: 4)
        secondBaseView.layer.cornerRadius = 20
        secondBGView.layer.cornerRadius = 20
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
