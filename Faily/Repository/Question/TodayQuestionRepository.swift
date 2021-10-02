//
//  TodayQuestionRepository.swift
//  Faily
//
//  Created by 구본의 on 2021/10/03.
//

import Foundation
import Alamofire

class TodayQuestionRepository {
    func getTodayQuestion(onCompleted: @escaping(TodayQuestionResponse) -> Void, onError: @escaping (String) -> Void) {
        let header: HTTPHeaders = [
            "jwt_token": UserDefaults.standard.string(forKey: UserDefaultKey.jwtToken)!
        ]
        
        AF.request("\(ConstantURL.BASE_URL)/todayQuestion", method: .get, headers: header)
            .validate()
            .responseDecodable(of: TodayQuestionResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("getTodayQuestion - repository")
                    onCompleted(response)
                case .failure(let error):
                    onError("postGroupCode - repository: \(error)")
                }
                
            }
    }
}
