//
//  EntryResponse.swift
//  Faily
//
//  Created by 구본의 on 2021/10/02.
//

import Foundation

struct EntryResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
