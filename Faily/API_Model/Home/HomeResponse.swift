//
//  HomeResponse.swift
//  Faily
//
//  Created by 구본의 on 2021/10/28.
//

import Foundation

struct HomeResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: HomeInfo?
    
}

struct HomeInfo: Decodable {
    let group_bonding: Float?
    let user_mood: String?
    let familyList: [FamilyListInfo]?
    let today_anniversary: [TodayAnniversaryInfo]?
    let today: String?
    let user_name: String?
}

struct FamilyListInfo: Decodable {
    let user_name: String?
    let user_bonding: Float?
    let user_image: String?
    let user_mood: String?
}

struct TodayAnniversaryInfo: Decodable {
    let calendar_name: String?
}
