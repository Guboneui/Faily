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
    
    lazy var viewModel: AllQuestionViewModel = AllQuestionViewModel()
    var keyWord: String = ""
    var page = 0
    var mainQuestionPage: Int = 0 {
        didSet{
            print("현재 페이지는: \(mainQuestionPage) ")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.questionView = self
        viewModelMethod()
        viewModel.getAllQuestion()
        setTableView()
    }
    
    func setTableView() {
        questionMainTableView.delegate = self
        questionMainTableView.dataSource = self
        questionMainTableView.rowHeight = UITableView.automaticDimension
        questionMainTableView.estimatedRowHeight = 75
        
        
        questionMainTableView.separatorStyle = .none
        
        questionMainTableView.register(UINib(nibName: "MainQuestionTableViewCell", bundle: nil), forCellReuseIdentifier: "MainQuestionTableViewCell")
        questionMainTableView.register(UINib(nibName: "AnsweredFamilyTableViewCell", bundle: nil), forCellReuseIdentifier: "AnsweredFamilyTableViewCell")
        questionMainTableView.register(UINib(nibName: "LockTableViewCell", bundle: nil), forCellReuseIdentifier: "LockTableViewCell")
        questionMainTableView.register(UINib(nibName: "EachAnswerTableViewCell", bundle: nil), forCellReuseIdentifier: "EachAnswerTableViewCell")
        questionMainTableView.register(UINib(nibName: "BottomWhiteLabelTableViewCell", bundle: nil), forCellReuseIdentifier: "BottomWhiteLabelTableViewCell")
        questionMainTableView.register(UINib(nibName: "ForFirstAnswerTableViewCell", bundle: nil), forCellReuseIdentifier: "ForFirstAnswerTableViewCell")
    }
}

extension QuestionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            
            if viewModel.questionData.count != 0 {
                
                let data = viewModel.questionData[self.mainQuestionPage]
                print(data)
                if data.isAnswered == false && data.allAnswered == false {
                    return 2
                    
                } else if data.isAnswered == true && data.allAnswered == false {
                    return 4
                    
                } else {
                    return data.answerInfo!.count + 2
                }
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainQuestionTableViewCell", for: indexPath) as! MainQuestionTableViewCell
            cell.allQuestionData = viewModel.questionData
            cell.questionCollectionView.reloadData()
            cell.questionView = self
            cell.selectionStyle = .none
            cell.questionDelegate = self
            
            //cell 레이아웃 변경 부분
            cell.layoutIfNeeded()
            cell.questionCollectionView.isPagingEnabled = false
            let collectionBounds = cell.questionCollectionView.bounds
            let contentOffset = CGFloat(floor(cell.questionCollectionView.contentOffset.x + collectionBounds.size.width * CGFloat(viewModel.questionData.count - 1)))
            DispatchQueue.main.async {
                cell.moveCollectionToFrame(contentOffset: contentOffset)
            }
            
            cell.questionCollectionView.isPagingEnabled = true
            
            return cell
            
        } else {
            if viewModel.questionData.count != 0 {
                
                let data = viewModel.questionData[self.mainQuestionPage]
                if data.isAnswered == false && data.allAnswered == false {
                    print("첫번째 답변을 입력 해보새요")
                    if indexPath.row == 0 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "ForFirstAnswerTableViewCell", for: indexPath) as! ForFirstAnswerTableViewCell
                        cell.selectionStyle = .none
                        return cell
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "BottomWhiteLabelTableViewCell", for: indexPath) as! BottomWhiteLabelTableViewCell
                        cell.selectionStyle = .none
                        return cell
                    }
                } else if data.isAnswered == true && data.allAnswered == false {
                    print("모두가 답변을 해야합니다")
                    if indexPath.row == 0 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "AnsweredFamilyTableViewCell", for: indexPath) as! AnsweredFamilyTableViewCell
                        cell.answeredFamilyCount = data.answerInfo?.count ?? 0
                        let imageName = "num\(data.answerInfo?.count ?? 1)"
                        cell.answeredFamilyCountImage.image = UIImage(named: imageName)
                        print("답변한 가족의 수: \(data.answerInfo?.count)")
                        cell.answeredCollectionView.reloadData()
                        cell.selectionStyle = .none
                        return cell
                    } else if indexPath.row == 1 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "EachAnswerTableViewCell", for: indexPath) as! EachAnswerTableViewCell
                        cell.selectionStyle = .none
                        return cell
                    } else if indexPath.row == 2 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "LockTableViewCell", for: indexPath) as! LockTableViewCell
                        cell.selectionStyle = .none
                        return cell
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "BottomWhiteLabelTableViewCell", for: indexPath) as! BottomWhiteLabelTableViewCell
                        cell.selectionStyle = .none
                        return cell
                    }
                } else {
                    print("가족 모두가 답변을 했습니다.")
                    if indexPath.row == 0 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "AnsweredFamilyTableViewCell", for: indexPath) as! AnsweredFamilyTableViewCell
                        cell.selectionStyle = .none
                        cell.answeredFamilyCount = data.answerInfo?.count ?? 0
                        let imageName = "num\(data.answerInfo?.count ?? 1)"
                        cell.answeredFamilyCountImage.image = UIImage(named: imageName)
                        print("답변한 가족의 수: \(data.answerInfo?.count)")
                        cell.answeredCollectionView.reloadData()
                        return cell
                    } else if indexPath.row == data.answerInfo!.count + 1 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "BottomWhiteLabelTableViewCell", for: indexPath) as! BottomWhiteLabelTableViewCell
                        cell.selectionStyle = .none
                        return cell
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "EachAnswerTableViewCell", for: indexPath) as! EachAnswerTableViewCell
                        cell.selectionStyle = .none
                        return cell
                    }
                }
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "EachAnswerTableViewCell", for: indexPath) as! EachAnswerTableViewCell
                cell.selectionStyle = .none
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return self.view.frame.width + 7.5 + 20
        } else {
            
            return UITableView.automaticDimension
            
//            if indexPath.row == 0 {
//                return self.view.frame.width + 7.5 + 20
//            } else if indexPath.row == 1{
//                return 105
//            } else if indexPath.row == 2{
//                return 75
//            } else {
//                return UITableView.automaticDimension
//            }
        }
    }
}



extension QuestionViewController {
    func viewModelMethod() {
        viewModel.reloadTableView = {
            self.questionMainTableView.reloadData()
        }
    }
}



extension QuestionViewController: ReloadQuestionTableViewDelegate {
    func reloadQuestionTableView() {
        let sectionToReload = 1
        let indexSet: IndexSet = [sectionToReload]
        DispatchQueue.main.async {
            self.questionMainTableView.reloadSections(indexSet, with: .fade)
            
        }
        
        
        
        print("현재 전달된 페이지는 \(self.mainQuestionPage)")
    }
}
