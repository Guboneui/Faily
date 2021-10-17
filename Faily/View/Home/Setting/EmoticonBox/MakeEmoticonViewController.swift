//
//  EmoticonBoxViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/08.
//

import UIKit


class MakeEmoticonViewController: UIViewController {

    
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
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let popUpVC = storyBoard.instantiateViewController(withIdentifier: "EmoticonPopUpViewController") as! EmoticonPopUpViewController
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.present(popUpVC, animated: false, completion: nil)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    

}

