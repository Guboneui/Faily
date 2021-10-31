//
//  SendChatRepository.swift
//  Faily
//
//  Created by 구본의 on 2021/11/01.
//

import Foundation
import Alamofire

class SendChatRepository {
    func postSendChat(_ parameters: SendChatRequest, onCompleted: @escaping (SendChatResponse) -> Void, onError: @escaping (String) -> Void) {
        let header: HTTPHeaders = [
            "jwt_token": UserDefaults.standard.string(forKey: UserDefaultKey.jwtToken)!
        ]
        
        AF.request("\(ConstantURL.BASE_URL)/chat/msg", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: SendChatResponse.self){ response in
                switch response.result {
                case.success(let response):
                    print("postSendChat - repository")
                    onCompleted(response)
                case .failure(let error):
                    onError("postSendChat - repository - \(error)")
                }
                
            }
    }
}
