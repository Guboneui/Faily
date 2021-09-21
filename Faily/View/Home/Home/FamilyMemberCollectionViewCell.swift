//
//  FamilyMemberCollectionViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/09/22.
//

import UIKit
import MKMagneticProgress

class FamilyMemberCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var progressBar: MKMagneticProgress!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var memberNameLabel: UILabel!
    @IBOutlet weak var memberEmotion: UILabel!
    
    
 
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configUI()
    }
    
    func configUI() {
        layoutIfNeeded()
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        
        let bounds = self.progressBar.bounds
        let color = gradientLayer(bounds: bounds,
                                  color1: UIColor.FailyColor.subGradientPinkColor.cgColor,
                                  color2: UIColor.FailyColor.secondaryPinkColor.cgColor)
        let borderColor = gradientColor(gradientLayer: color)
        progressBar.progressShapeColor = borderColor!
        progressBar.backgroundShapeColor = .clear
        progressBar.orientation = .top
        progressBar.setProgress(progress: 0.75)
        
        
       
        
    }
    
    func gradientLayer(bounds : CGRect,
                       color1: CGColor,
                       color2: CGColor) -> CAGradientLayer{
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [color1, color2]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradient
    }
    
    // 그래디언트 레이어로 그래디언트 색 만들기
    func gradientColor(gradientLayer :CAGradientLayer) -> UIColor? {
        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, false, 0.0)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIColor(patternImage: image!)
    }
    
    

}
