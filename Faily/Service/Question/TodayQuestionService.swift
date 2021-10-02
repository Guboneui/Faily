//
//  TodayQuestionService.swift
//  Faily
//
//  Created by 구본의 on 2021/10/03.
//

import Foundation

class TodayQuestionService {
    let repository: TodayQuestionRepository = TodayQuestionRepository()
    
    func getTodayQuestion(onCompleted: @escaping (TodayQuestionResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.getTodayQuestion(onCompleted: {response in
            let responseData = TodayQuestionResponse(isSuccess: response.isSuccess, code: response.code, message: response.message, todayQuestion: response.todayQuestion)
            onCompleted(responseData)
        }, onError: onError)
    }
}
