//
//  InviteRepository.swift
//  Faily
//
//  Created by 구본의 on 2021/10/01.
//

import Foundation
import Alamofire

class InviteRepository {
    func postGroupCode(_ parameters: InviteRequest, onCompleted: @escaping (InviteResponse) -> Void, onError: @escaping (String) -> Void) {
        let header: HTTPHeaders = [
            "jwt_token": UserDefaults.standard.string(forKey: UserDefaultKey.jwtToken)!
        ]
        AF.request("\(ConstantURL.BASE_URL)/GroupCode", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: InviteResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("postGroupCode - repository")
                    onCompleted(response)
                
                case .failure(let error):
                    onError("postGroupCode - repository: \(error)")
                }
                
            }
    }
}
