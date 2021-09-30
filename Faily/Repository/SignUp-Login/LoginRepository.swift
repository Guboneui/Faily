//
//  LoginRepository.swift
//  Faily
//
//  Created by 구본의 on 2021/09/30.
//

import Foundation
import Alamofire

class LoginRepository {
    func postLogin(_ parameters: LoginRequest, onCompleted: @escaping (LoginResponse) -> Void, onError: @escaping (String) -> Void) {
        AF.request("\(ConstantURL.BASE_URL)/login", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("postLogin - repository")
                    onCompleted(response)
                case .failure(let error):
                    onError("postLogin - repository: \(error)")
                }
                
            }
    }
}
