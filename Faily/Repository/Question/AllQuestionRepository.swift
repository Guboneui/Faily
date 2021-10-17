//
//  AllQuestionRepository.swift
//  Faily
//
//  Created by 구본의 on 2021/10/17.
//

import Foundation
import Alamofire

class AllQuestionRepository {
    func getAllQuestion(onCompleted: @escaping(AllQuestionResponse) -> Void, onError: @escaping (String) -> Void) {
        let header: HTTPHeaders = [
            "jwt_token": UserDefaults.standard.string(forKey: UserDefaultKey.jwtToken)!
        ]
        
        
        AF.request("\(ConstantURL.BASE_URL)/allQuestion", method: .get, headers: header)
            .validate()
            .responseDecodable(of: AllQuestionResponse.self) {response in
                switch response.result {
                case .success(let response):
                    print("getAllQeustion - repository")
                    onCompleted(response)
                case .failure(let error):
                    onError("getAllQuestion - repository: \(error)")
                
                }
            }
    }
}
