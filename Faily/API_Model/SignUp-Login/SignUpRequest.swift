//
//  SignUpRequest.swift
//  Faily
//
//  Created by 구본의 on 2021/09/28.
//

import Foundation

struct SignUpRequest: Encodable {
    let user_email: String
    let user_pw: String
    let user_name: String
    let user_bdate: String
}
