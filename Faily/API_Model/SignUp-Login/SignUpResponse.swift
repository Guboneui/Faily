//
//  SignUpResponse.swift
//  Faily
//
//  Created by 구본의 on 2021/09/28.
//

import Foundation

struct SignUpResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let jwt_token: String
}
