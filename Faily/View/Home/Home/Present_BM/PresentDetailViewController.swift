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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
