//
//  ChatViewModel.swift
//  Faily
//
//  Created by 구본의 on 2021/11/01.
//

import Foundation
import UIKit

class ChatViewModel {
    weak var chatView: ChatViewController?
    let useService = SendChatService()
    let getChatService = GetChatService()
    
    var reloadTableView: () -> Void = {}
    
    var chatInfo: [ChatInfo] = [] {
        didSet {
            self.reloadTableView()
        }
    }
    
    func postSendChat(_ parameters: SendChatRequest) {
        useService.postSendChat(parameters, onCompleted: {[weak self] response in
            guard let self = self else {return}
            
            if response.isSuccess == true {
                print("채팅 전달 성공")
                
                
                SoketIOManager.shared.sendMessage(
                    file: parameters.file ?? "",
                    content: parameters.content ?? "",
                    emoji: parameters.emoji ?? false,
                    photo: parameters.photo ?? false,
                    calendar: parameters.calendar ?? false,
                    text: parameters.text ?? false
                )
                
                
                
                
            } else {
                print("채팅 실패")
            }
        }, onError: {error in
            print("sendChatViewModel = \(error)")
        })
    }
    
    func getChatInfo() {
        getChatService.getChatInfo(onCompleted: {[weak self] response in
            guard let self = self else {return}
            if response.isSuccess == true {
                print("채팅방 목록 불러오기")
                self.chatInfo = response.result
                
                
                
                
            } else {
                print("채팅방 목록 불러오기 실패")
            }
        }, onError: {error in
            print("sendChatviewmodel = \(error)")
        })
    }
}





