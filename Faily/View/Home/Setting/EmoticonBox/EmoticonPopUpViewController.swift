//
//  EmoticonPopUpViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/17.
//

import UIKit

class EmoticonPopUpViewController: UIViewController {

    @IBOutlet weak var popUpBaseView: UIView!
    @IBOutlet weak var resultImage: UIImageView!
    
    var combinedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    
    func configUI() {
        self.popUpBaseView.layer.cornerRadius = 15
        self.makeShadow(popUpBaseView)
        resultImage.image = combinedImage
        
        resultImage.layer.borderWidth = 1
        resultImage.layer.borderColor = UIColor.FailyColor.grayscale_5.cgColor
        
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    

    @IBAction func saveButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
