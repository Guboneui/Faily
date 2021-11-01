//
//  PostDeleteEmoticonResponse.swift
//  Faily
//
//  Created by 구본의 on 2021/11/02.
//

import Foundation

struct PostDeleteEmoticonResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
