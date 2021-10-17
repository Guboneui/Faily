//
//  AllQuestionViewModel.swift
//  Faily
//
//  Created by 구본의 on 2021/10/17.
//

import Foundation

class AllQuestionViewModel {
    weak var questionView: QuestionViewController?
    let useService = AllQuestionService()
    
    func getAllQuestion() {
        useService.getAllQuestion(onCompleted: {[weak self] response in
            guard let self = self else {return}
            let message = response.message
            let code = response.code
            if response.isSuccess == true {
                print("전체 질문을 불러왔습니다.")
            } else {
                print("전체 질문을 불러오지 못했습니다.")
            }
        }, onError: {error in
            print("AllQuestionViewModel - \(error)")
        })
    }
}
