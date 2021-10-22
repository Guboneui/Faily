//
//  SendAnswerRepository.swift
//  Faily
//
//  Created by 구본의 on 2021/10/23.
//

import Foundation
import Alamofire

class SendAnswerRepository {
    func postSendAnswer(_ parameters: SendAnswerRequest, onCompleted: @escaping (SendAnswerResponse) -> Void, onError: @escaping (String) -> Void) {
        
        let header: HTTPHeaders = [
            "jwt_token": UserDefaults.standard.string(forKey: UserDefaultKey.jwtToken)!
        ]
        
        AF.request("\(ConstantURL.BASE_URL)/SendAnswer", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: SendAnswerResponse.self) {response in
                switch response.result {
                case .success(let response):
                    onCompleted(response)
                
                case .failure(let error):
                    onError("sendAnswerRepository: \(error)")
                }
            }
        
    }
    
   
    
}
