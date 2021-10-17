//
//  AllQuestionService.swift
//  Faily
//
//  Created by 구본의 on 2021/10/17.
//

import Foundation

class AllQuestionService {
    let repository: AllQuestionRepository = AllQuestionRepository()
    
    func getAllQuestion(onCompleted: @escaping(AllQuestionResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.getAllQuestion(onCompleted: {response in
            let responseData = AllQuestionResponse(isSuccess: response.isSuccess, code: response.code, message: response.message, result: response.result)
            onCompleted(responseData)
        }, onError: onError)
    }
}
