//
//  GetAllEmoticonRepository.swift
//  Faily
//
//  Created by 구본의 on 2021/11/01.
//

import Foundation
import Alamofire

class GetAllEmoticonRepository {
    func getAllEmoticon(onCompleted: @escaping(GetAllEmoticonResponse) -> Void, onError: @escaping(String) -> Void) {
        let header: HTTPHeaders = [
            "jwt_token": UserDefaults.standard.string(forKey: UserDefaultKey.jwtToken)!
        ]
        AF.request("\(ConstantURL.BASE_URL)/emojis", method: .get, headers: header)
            .validate()
            .responseDecodable(of: GetAllEmoticonResponse.self){ response in
                switch response.result {
                case.success(let response):
                    print("GetAllEmoticonRepository - repository")
                    onCompleted(response)
                case .failure(let error):
                    onError("GetAllEmoticonRepository - repository - \(error)")
                }
                
            }
    }
}
