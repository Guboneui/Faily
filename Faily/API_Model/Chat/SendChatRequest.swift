//
//  SendChatRequest.swift
//  Faily
//
//  Created by 구본의 on 2021/11/01.
//

import Foundation

struct SendChatRequest: Encodable {
    let file: String?
    let content: String?
    let emoji: Bool?
    let photo: Bool?
    let calendar: Bool?
    let text: Bool?
}
