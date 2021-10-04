//
//  TodayQuestionViewModel.swift
//  Faily
//
//  Created by 구본의 on 2021/10/04.
//

import Foundation

class TodayQuestionViewModel {
    weak var questionView: QuestionViewController?
    let useService = TodayQuestionService()
    
    func getTodayQuestion() {
        useService.getTodayQuestion(onCompleted: { [weak self] response in
            guard let self = self else {return}
            let message = response.message
            let code = response.code
            
            if response.isSuccess == true {
                print("오늘의 질문을 받아왔습니다.")
                print("오늘의 질문은 <\(response.todayQuestion)>입니다.")
            } else {
                print("\(code) Error")
            
            }
        }, onError: {error in
            print("todayQuestionViewModel - \(error)")
        })
    }
}
