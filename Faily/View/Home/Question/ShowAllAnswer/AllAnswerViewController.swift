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
    
    var allAnswerData: [AllQuestionDetail] = []
    
    
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
        allAnswerTableView.register(UINib(nibName: "ExpandableForFirstTableViewCell", bundle: nil), forCellReuseIdentifier: "ExpandableForFirstTableViewCell")
        allAnswerTableView.register(UINib(nibName: "ExpandableLockTableViewCell", bundle: nil), forCellReuseIdentifier: "ExpandableLockTableViewCell")
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
        print("테이블뷰 생성됌")
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllAnswerBaseTableViewCell") as! AllAnswerBaseTableViewCell
        cell.selectionStyle = .none
        cell.numberLabel.text = "\(self.allAnswerData.count - section)"
        cell.dateLabel.text = self.allAnswerData[self.allAnswerData.count - 1 - section].date
        cell.questionLabel.text = self.allAnswerData[self.allAnswerData.count - 1 - section].question
        cell.data = self.allAnswerData
        cell.getMemberCount = self.allAnswerData[self.allAnswerData.count - 1 - section].answerInfo!.count
        
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allAnswerData.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "AllAnswerExpandTableViewCell") as! AllAnswerExpandTableViewCell
//        cell.selectionStyle = .none
//
        
        
        let data = allAnswerData[allAnswerData.count - 1 - indexPath.section]
        let answerInfo = data.answerInfo
        if data.allAnswered == false && data.isAnswered == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableForFirstTableViewCell", for: indexPath) as! ExpandableForFirstTableViewCell
            cell.selectionStyle = .none
            return cell
        } else if data.allAnswered == false && data.isAnswered == true {
            
            if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AllAnswerExpandTableViewCell") as! AllAnswerExpandTableViewCell
                cell.selectionStyle = .none
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableLockTableViewCell", for: indexPath) as! ExpandableLockTableViewCell
                cell.selectionStyle = .none
                return cell
            }
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllAnswerExpandTableViewCell") as! AllAnswerExpandTableViewCell
            cell.selectionStyle = .none
            return cell
        }
        
        
//
//        cell.nameLabel.text = answerInfo?[indexPath.row - 1].user_name
//        cell.answerLabel.text = answerInfo?[indexPath.row - 1].answer


//        if indexPath.row == 4 {
//            cell.guideLineView.isHidden = false
//        } else {
//            cell.guideLineView.isHidden = true
//        }
        
        
        //return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let data = allAnswerData[allAnswerData.count - 1 - section]
        if data.isAnswered == false && data.allAnswered == false {
            return 2
        } else if data.allAnswered == false && data.isAnswered == true {
            return 3
        } else {
            return allAnswerData[allAnswerData.count - 1 - section].answerInfo!.count + 1
        }
        
        
    }
}
