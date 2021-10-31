//
//  GetChatRepository.swift
//  Faily
//
//  Created by 구본의 on 2021/11/01.
//

import Foundation
import Alamofire
class GetChatRepository {
    func getChatInfo(onCompleted: @escaping(ChatResponse) -> Void, onError: @escaping(String) -> Void) {
        let header: HTTPHeaders = [
            "jwt_token": UserDefaults.standard.string(forKey: UserDefaultKey.jwtToken)!
        ]
        AF.request("\(ConstantURL.BASE_URL)/chat/list", method: .get, headers: header)
            .validate()
            .responseDecodable(of: ChatResponse.self){ response in
                switch response.result {
                case.success(let response):
                    print("getChatInfo - repository")
                    onCompleted(response)
                case .failure(let error):
                    onError("getChatInfo - repository - \(error)")
                }
                
            }
    
    }
}
