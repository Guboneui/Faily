//
//  AuthEmailRepository.swift
//  Faily
//
//  Created by 구본의 on 2021/09/30.
//

import Foundation
import Alamofire

class AuthEmailRepository {
    func postAuthEmail(_ parameters: AuthEmailRequest, onCompleted: @escaping (AuthEmailResponse) -> Void, onError: @escaping (String) -> Void) {
        AF.request("\(ConstantURL.BASE_URL)/SendEmail", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: AuthEmailResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("postAuthEmail - repository")
                    onCompleted(response)
                case .failure(let error):
                    onError("postAuthEmail - repository: \(error)")
                }
            }
    }
}
