//
//  GalleryViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/16.
//

import UIKit

class GalleryViewController: UIViewController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        
    }
    
    
    @IBAction func addGalleryCategoryAction(_ sender: Any) {
        let alert = UIAlertController(title: "갤러리", message: "추가할 카테고리 이름을 입력 해주세요.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "카테고리"
        }
        let cancelButton = UIAlertAction(title: "취소", style: .default, handler: nil)
        let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
