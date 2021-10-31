//
//  GetAllEmoticon.swift
//  Faily
//
//  Created by 구본의 on 2021/11/01.
//

import Foundation

struct GetAllEmoticonResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [EmoticonInfo]?
}

struct EmoticonInfo: Decodable {
    let emoji: String
    let emoji_id: Int
    let time: String
}
