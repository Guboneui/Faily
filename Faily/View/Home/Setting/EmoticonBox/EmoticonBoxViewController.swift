//
//  EmoticonBoxViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/08.
//

import UIKit

class EmoticonBoxViewController: UIViewController {

    
    @IBOutlet weak var designBottomView: UIView!
    
    override func loadView() {
        super.loadView()
        
        designBottomView.layer.cornerRadius = 20
        designBottomView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
            
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    
    }
    
    
   
    @IBAction func selectedButtonAction(_ sender: Any) {
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    

}

