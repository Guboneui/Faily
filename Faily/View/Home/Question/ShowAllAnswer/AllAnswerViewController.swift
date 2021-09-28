//
//  AllAnswerViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/29.
//

import UIKit
import ExpyTableView

class AllAnswerViewController: UIViewController {

    @IBOutlet weak var allAnswerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        // Do any additional setup after loading the view.
    }
    
    func setTableView() {
        allAnswerTableView.delegate = self
        allAnswerTableView.dataSource = self
        allAnswerTableView.separatorStyle = .none
        allAnswerTableView.rowHeight = ExpyTableView.automaticDimension
        allAnswerTableView.estimatedRowHeight = 20
        allAnswerTableView.register(UINib(nibName: "AllAnswerBaseTableViewCell", bundle: nil), forCellReuseIdentifier: "AllAnswerBaseTableViewCell")
        allAnswerTableView.register(UINib(nibName: "AllAnswerExpandTableViewCell", bundle: nil), forCellReuseIdentifier: "AllAnswerExpandTableViewCell")
    }
    
    @IBAction func dismissButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AllAnswerViewController: ExpyTableViewDelegate, ExpyTableViewDataSource {
    func tableView(_ tableView: ExpyTableView, expyState state: ExpyState, changeForSection section: Int) {
        switch state {
        case .willExpand:
            print("willExpand 펼쳐질 예정")
        case .willCollapse:
            print("willCollapse 닫힐 예정")
        case .didExpand:
            print("didExpand 펼쳐짐")
        case .didCollapse:
            print("didCollapse 닫힘")
        }
    }
    
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        return true
    }
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllAnswerBaseTableViewCell") as! AllAnswerBaseTableViewCell
        cell.selectionStyle = .none
        if section == 3 {
            cell.questionLabel.text = "Eleifend sit senectus malesuada fusce sociis nunc. Quis egestas quisque est ipsum sagittis sed dictum. Adipiscing ut augue diam sed aliquam faucibus egestas enim ultricies. Quam nullam amet consec"
        }
        cell.numberLabel.text = "\(7 - section)"
        return cell
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllAnswerExpandTableViewCell") as! AllAnswerExpandTableViewCell
        cell.selectionStyle = .none
        if indexPath.row == 3 {
            cell.answerLabel.text = "Eleifend sit senectus malesuada fusce sociis nunc. Quis egestas quisque est ipsum sagittis sed dictum. Adipiscing ut augue diam sed aliquam faucibus egestas enim ultricies. Quam nullam amet consectetur ultrice.Eleifend sit senectus malesuada fusce sociis nunc. Quis egestas quisque est ipsum sagittis sed dictum. Adipiscing ut augue diam sed aliquam faucibus egestas enim ultricies. Quam nullam amet consectetur ultrice.Eleifend sit senectus malesuada fusce sociis nunc. Quis egestas quisque est ipsum sagittis sed dictum. Adipiscing ut augue diam sed aliquam faucibus egestas enim ultricies. Quam nullam amet consectetur ultrice.Eleifend sit senectus malesuada fusce sociis nunc. Quis egestas quisque est ipsum sagittis sed dictum. Adipiscing ut augue diam sed aliquam faucibus egestas enim ultricies. Quam nullam amet consectetur ultrice.Eleifend sit senectus malesuada fusce sociis nunc. Quis egestas quisque est ipsum sagittis sed dictum. Adipiscing ut augue diam sed aliquam faucibus egestas enim ultricies. Quam nullam amet consectetur ultrice.Eleifend sit senectus malesuada fusce sociis nunc. Quis egestas quisque est ipsum sagittis sed dictum. Adipiscing ut augue diam sed aliquam faucibus egestas enim ultricies. Quam nullam amet consectetur ultrice."
        }
        
     
        
        if indexPath.row == 4 {
            cell.guideLineView.isHidden = false
        } else {
            cell.guideLineView.isHidden = true
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
   
    
    
}
