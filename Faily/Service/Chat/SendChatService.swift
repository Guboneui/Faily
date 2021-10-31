//
//  SendChatService.swift
//  Faily
//
//  Created by 구본의 on 2021/11/01.
//

import Foundation

class SendChatService {
    let repository: SendChatRepository = SendChatRepository()
    func postSendChat(_ parameters: SendChatRequest, onCompleted: @escaping(SendChatResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.postSendChat(parameters, onCompleted: { response in
            let responseData = SendChatResponse(isSuccess: response.isSuccess, code: response.code, message: response.message, content: response.content, file: response.file, sender: response.sender, group_code: response.group_code, chatting_time: response.chatting_time, emoji: response.emoji, photo: response.photo, calendar: response.calendar, text: response.text)
            
            onCompleted(responseData)
        }, onError: {error in
            onError(error)
        })
    }
    
}


