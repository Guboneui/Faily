//
//  HomeBusinessCollectionViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/09/21.
//

import UIKit

class HomeBusinessCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var bmImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    func configUI(){
        baseView.layer.cornerRadius = 20
        bmImageView.layer.cornerRadius = 20
        
        
    }

}
