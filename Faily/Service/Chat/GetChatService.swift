//
//  GetChatService.swift
//  Faily
//
//  Created by 구본의 on 2021/11/01.
//

import Foundation

class GetChatService {
    let repository: GetChatRepository = GetChatRepository()
    
    func getChatInfo(onCompleted: @escaping(ChatResponse) -> Void, onError: @escaping(String) -> Void) {
        repository.getChatInfo(onCompleted: {response in
            let responseData = ChatResponse(isSuccess: response.isSuccess, code: response.code, message: response.message, result: response.result)
            onCompleted(responseData)
        }, onError: {error in
            onError(error)
        })
    }
}
