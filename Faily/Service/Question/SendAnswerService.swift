//
//  SendAnswerService.swift
//  Faily
//
//  Created by 구본의 on 2021/10/23.
//

import Foundation

class SendAnswerService {
    let repository: SendAnswerRepository = SendAnswerRepository()
    func postSendAnswer(_ parameters: SendAnswerRequest, onCompleted: @escaping(SendAnswerResponse) -> Void, onError: @escaping(String) -> Void) {
        repository.postSendAnswer(parameters, onCompleted: {response in
            let responseData = SendAnswerResponse(isSuccess: response.isSuccess, code: response.code, message: response.message)
            onCompleted(responseData)
        }, onError: onError)
    }
}
