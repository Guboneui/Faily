//
//  PostMakeEmoticonResponse.swift
//  Faily
//
//  Created by 구본의 on 2021/11/01.
//

import Foundation

struct PostMakeEmoticonResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
