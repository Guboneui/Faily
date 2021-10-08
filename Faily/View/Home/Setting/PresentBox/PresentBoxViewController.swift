//
//  PresentBoxViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/07.
//

import UIKit

class PresentBoxViewController: UIViewController {

    @IBOutlet weak var presentBoxTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
    }
    
    func setTableView() {
        presentBoxTableView.delegate = self
        presentBoxTableView.dataSource = self
        presentBoxTableView.separatorStyle = .none
        presentBoxTableView.register(UINib(nibName: "MyPresentBoxTableViewCell", bundle: nil), forCellReuseIdentifier: "MyPresentBoxTableViewCell")
        presentBoxTableView.register(UINib(nibName: "MyPresentBoxGuideLineTableViewCell", bundle: nil), forCellReuseIdentifier: "MyPresentBoxGuideLineTableViewCell")
        presentBoxTableView.register(UINib(nibName: "MyOrderTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "MyOrderTitleTableViewCell")
        presentBoxTableView.register(UINib(nibName: "MyPresentOrderDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "MyPresentOrderDetailTableViewCell")
        
    }
    

    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension PresentBoxViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyPresentBoxTableViewCell", for: indexPath) as! MyPresentBoxTableViewCell

            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyPresentBoxGuideLineTableViewCell", for: indexPath) as! MyPresentBoxGuideLineTableViewCell
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderTitleTableViewCell", for: indexPath) as! MyOrderTitleTableViewCell

            cell.selectionStyle = .none
            return cell
        } else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyPresentOrderDetailTableViewCell", for: indexPath) as! MyPresentOrderDetailTableViewCell
            cell.selectionStyle = .none
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            //return self.presentBoxTableView.frame.height * 0.31
            return 225

        } else {
            return UITableView.automaticDimension
        }
    }

}
