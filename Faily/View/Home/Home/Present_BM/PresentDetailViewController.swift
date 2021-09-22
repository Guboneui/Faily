//
//  PresentDetailViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/23.
//

import UIKit

class PresentDetailViewController: UIViewController {

    @IBOutlet weak var naviTitleLabel: UILabel!
    
    var getNaviTitle: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        naviTitleLabel.text = getNaviTitle
    }
    

    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
