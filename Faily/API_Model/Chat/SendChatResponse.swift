//
//  SendChatResponse.swift
//  Faily
//
//  Created by 구본의 on 2021/11/01.
//

import Foundation

struct SendChatResponse: Decodable {
    let isSuccess : Bool
    let code : Int
    let message : String
    let content : String?
    let file: String?
    let sender :  String?
    let group_code : String?
    let chatting_time : String?
    let emoji : Bool?
    let photo: Bool?
    let calendar : Bool?
    let text : Bool?
}
