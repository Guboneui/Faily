//
//  ScheduleDivisionTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/09/23.
//

import UIKit

class ScheduleDivisionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var scheduleImage: UIImageView!
    @IBOutlet weak var scheduleTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
