//
//  ChatInfoResponse.swift
//  Faily
//
//  Created by 구본의 on 2021/11/01.
//

import Foundation

struct ChatResponse: Decodable {
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : [ChatInfo]
    
}

struct ChatInfo: Decodable {
    let unread : Int
    let sender_name : String
    let content : String
    let file: String
    let chatting_time : String
    let emoji: Bool
    let photo: Bool
    let text: Bool
    let calendar: Bool
}
