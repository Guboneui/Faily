//
//  QuestionViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/16.
//

import UIKit
import CollectionViewPagingLayout

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionMainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionMainTableView.delegate = self
        questionMainTableView.dataSource = self
        questionMainTableView.rowHeight = UITableView.automaticDimension
        questionMainTableView.estimatedRowHeight = 75
        
        
        questionMainTableView.separatorStyle = .none
        
        questionMainTableView.register(UINib(nibName: "MainQuestionTableViewCell", bundle: nil), forCellReuseIdentifier: "MainQuestionTableViewCell")
        questionMainTableView.register(UINib(nibName: "AnsweredFamilyTableViewCell", bundle: nil), forCellReuseIdentifier: "AnsweredFamilyTableViewCell")
        questionMainTableView.register(UINib(nibName: "LockTableViewCell", bundle: nil), forCellReuseIdentifier: "LockTableViewCell")
        questionMainTableView.register(UINib(nibName: "EachAnswerTableViewCell", bundle: nil), forCellReuseIdentifier: "EachAnswerTableViewCell")
        
        
    }

}

extension QuestionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainQuestionTableViewCell", for: indexPath) as! MainQuestionTableViewCell
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnsweredFamilyTableViewCell", for: indexPath) as! AnsweredFamilyTableViewCell
            cell.selectionStyle = .none
            
            return cell
        } else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LockTableViewCell", for: indexPath) as! LockTableViewCell
            cell.selectionStyle = .none
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EachAnswerTableViewCell", for: indexPath) as! EachAnswerTableViewCell
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return self.view.frame.width + 7.5 + 20
        } else if indexPath.row == 1{
            return 105
        } else if indexPath.row == 2{
            return 75
        } else {
            return UITableView.automaticDimension
        }
    }
}
