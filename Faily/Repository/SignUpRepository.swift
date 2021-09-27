//
//  SignUpRepository.swift
//  Faily
//
//  Created by 구본의 on 2021/09/28.
//

import Foundation
import Alamofire

class SignUpRepository {
    func postSignUp(_ parameters: SignUpRequest, onCompleted: @escaping (SignUpResponse) -> Void, onError: @escaping (String) -> Void) {
        AF.request("\(ConstantURL.BASE_URL)/joindo", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: SignUpResponse.self){ response in
                switch response.result {
                case.success(let response):
                    print("postSignUp - repository")
                    onCompleted(response)
                case .failure(let error):
                    onError("postSignup - repository - \(error)")
                }
                
            }
    }
}
